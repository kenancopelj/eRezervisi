using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.FavoriteAccommodationUnit;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.Storage;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Hangfire;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class AccommodationUnitService : IAccommodationUnitService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IStorageService _storageService;
        private readonly IBackgroundJobClient _backgroundJobClient;

        public AccommodationUnitService(eRezervisiDbContext dbContext,
            IMapper mapper,
            IJwtTokenReader jwtTokenReader,
            IStorageService storageService,
            IBackgroundJobClient backgroundJobClient)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _jwtTokenReader = jwtTokenReader;
            _storageService = storageService;
            _backgroundJobClient = backgroundJobClient;
        }

        public async Task<AccommodationUnitGetDto> ActivateAccommodationUnitAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id);

            NotFoundException.ThrowIfNull(accommodationUnit);

            accommodationUnit.Activate();

            await _dbContext.SaveChangesAsync(cancellationToken);

            _backgroundJobClient.Enqueue<INotifyService>(x => x.NotifyUsersAboutAccommodationUnitStatus(id));

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task<PagedResponse<AccommodationUnitGetDto>> GetAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.AccommodationUnits.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnit>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var accommodationUnits = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnit, bool>> FilterExpression)>()
                {
                    (!string.IsNullOrEmpty(searchTerm), x => x.Title.ToLower().Contains(searchTerm)),
                    (request.OwnerId.HasValue, x => x.OwnerId == request.OwnerId!.Value),
                    (request.CategoryId.HasValue, x => x.AccommodationUnitCategoryId == request.CategoryId!.Value),
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new AccommodationUnitGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Price = (double)x.Price,
                    Note = x.Note,
                    Category = new CategoryGetDto
                    {
                        Id = x.AccommodationUnitCategoryId,
                        Title = x.AccommodationUnitCategory.Title
                    },
                    Policy = new Common.Dtos.AccommodationUnitPolicy.PolicyGetDto
                    {
                        AlcoholAllowed = x.AccommodationUnitPolicy.AlcoholAllowed,
                        Capacity = x.AccommodationUnitPolicy.Capacity,
                        BirthdayPartiesAllowed = x.AccommodationUnitPolicy.BirthdayPartiesAllowed,
                        HasPool = x.AccommodationUnitPolicy.HasPool,
                        OneNightOnly = x.AccommodationUnitPolicy.OneNightOnly,
                    },
                    Township = new TownshipGetDto
                    {
                        Id = x.TownshipId,
                        Title = x.Township.Title,
                        CantonId = x.Township.CantonId,
                        Canton = new CantonGetDto
                        {
                            Id = x.Township.CantonId,
                            Title = x.Township.Canton.Title,
                            ShortTitle = x.Township.Canton.ShortTitle,
                        }
                    },
                    Latitude = x.Latitude,
                    Longitude = x.Longitude,
                    ThumbnailImage = x.ThumbnailImage,
                    Favorite = _dbContext.FavoriteAccommodationUnits.Any(f => f.Id == x.Id && x.CreatedBy == userId),
                    Images = x.Images.Select(i => new ImageGetDto
                    {
                        Id = i.Id,
                        FileName = i.FileName,
                    }).ToList(),
                }, cancellationToken);

            return accommodationUnits;
        }

        public async Task<AccommodationUnitGetDto> CreateAccommodationUnitAsync(AccommodationUnitCreateDto request, CancellationToken cancellationToken)
        {
            DuplicateException.ThrowIf(await _dbContext.AccommodationUnits.AnyAsync(x => x.Title == request.Title, cancellationToken));

            var ownerId = _jwtTokenReader.GetUserIdFromToken();

            var user = await _dbContext.Set<User>().FirstOrDefaultAsync(x => x.Id == ownerId);

            NotFoundException.ThrowIfNull(user);

            if (user.RoleId != Roles.Owner.Id)
            {
                user.ChangeRole(Roles.Owner.Id);
            }

            var thumbnailImage = request.Files.FirstOrDefault(x => x.IsThumbnail);

            if (thumbnailImage == null)
            {
                throw new DomainException("ThumbnailImageRequired", "Odaberite thumbnail sliku");
            }

            var accommodationUnit = _mapper.Map<AccommodationUnit>(request);

            var thumbImage = await _storageService.UploadFileAsync(FileType.AccommodationUnitLogo, thumbnailImage.ImageFileName, thumbnailImage.ImageBase64, cancellationToken);

            accommodationUnit.ThumbnailImage = thumbImage.FileName;

            accommodationUnit.OwnerId = ownerId;

            accommodationUnit.Status = AccommodationUnitStatus.Registered;

            var uploadedImages = new List<Image>();

            foreach (var item in request.Files)
            {
                var uploadedFile = await _storageService.UploadFileAsync(FileType.AccommodationUnitLogo, item.ImageFileName, item.ImageBase64, cancellationToken);

                accommodationUnit.Images.Add(new Image
                {
                    FileName = uploadedFile.FileName
                });
            }

            await _dbContext.AddAsync(accommodationUnit, cancellationToken);

            accommodationUnit.AccommodationUnitPolicy ??= _mapper.Map<AccommodationUnitPolicy>(request.Policy);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task<AccommodationUnitGetDto> DeactivateAccommodationUnitAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var lastReservation = await _dbContext.Reservations.Where(x => x.AccommodationUnitId == id && x.Status == ReservationStatus.InProgress)
                .OrderByDescending(x => x.To)
                .FirstOrDefaultAsync(cancellationToken);

            var deactivationDate = DateOnly.FromDateTime(DateTime.UtcNow);

            if (lastReservation != null)
            {
                deactivationDate = DateOnly.FromDateTime(lastReservation.To.AddDays(1));
            }

            accommodationUnit.Deactivate(deactivationDate);

            await _dbContext.SaveChangesAsync(cancellationToken);

            _backgroundJobClient.Enqueue<INotifyService>(x => x.NotifyUsersAboutAccommodationUnitStatus(id));

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task DeleteAccommodationUnitAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            accommodationUnit.Deleted = true;
            accommodationUnit.DeletedAt = DateTime.UtcNow;
            accommodationUnit.DeletedBy = _jwtTokenReader.GetUserIdFromToken();

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task<AccommodationUnitGetDto> GetAccommodationUnitByIdAsync(long id, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var accommodationUnit = await _dbContext.AccommodationUnits
                .Include(x => x.AccommodationUnitCategory)
                .Include(x => x.Images)
                .Include(x => x.Township).ThenInclude(x => x.Canton)
                .Include(x => x.AccommodationUnitPolicy)
                .FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var response = _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);

            response.Favorite = await _dbContext.FavoriteAccommodationUnits.AnyAsync(x => x.AccommodationUnitId == id && x.CreatedBy == userId);

            return response;
        }

        public async Task<PagedResponse<GetReviewsResponse>> GetAccommodationUnitReviewsPagedAsync(GetAccommodationUnitReviewsRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.AccommodationUnits.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnit>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var reviews = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnit, bool>> FilterExpression)>()
                {
                    (true, x => x.Id == request.AccommodationUnitId)
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new GetReviewsResponse
                {
                    Reviews = x.Reviews == null ? new() : x.Reviews.Select(x => new ReviewGetDto
                    {
                        Id = x.ReviewId,
                        Note = x.Review.Note,
                        Title = x.Review.Title,
                        Rating = x.Review.Rating,
                    }).ToList()
                }, cancellationToken);

            return reviews;
        }

        public async Task<AccommodationUnitGetDto> UpdateAccommodationUnitAsync(long id, AccommodationUnitUpdateDto request, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            DuplicateException.ThrowIf(await _dbContext.AccommodationUnits.AnyAsync(x => x.Title == request.Title && x.Id != id, cancellationToken));

            _mapper.Map<AccommodationUnit>(request);

            accommodationUnit.AccommodationUnitPolicy ??= _mapper.Map<AccommodationUnitPolicy>(request.Policy);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task<ReviewGetDto> CreateAccommodationUnitReviewAsync(long id, ReviewCreateDto request, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var userId = _jwtTokenReader.GetUserIdFromToken();

            if (await _dbContext.Reservations.AnyAsync(x => x.UserId == userId && x.AccommodationUnitId == accommodationUnit.Id && x.Status == ReservationStatus.InProgress))
            {
                throw new DomainException("ReservationInProgress", "Recenziju ovog objekta možete objaviti nakon završetka Vaše rezervacije");
            }

            var hasPreviousReservation = await _dbContext.Reservations
                                         .AsNoTracking()
                                         .AnyAsync(x => x.AccommodationUnitId == id && x.UserId == userId
                                         && x.Status == ReservationStatus.Confirmed, cancellationToken);

            if (!hasPreviousReservation)
            {
                throw new DomainException("NotGuest", "Ne možete napraviti recenziju objekta za koji nemate ili niste imali rezervaciju");
            }

            var review = _mapper.Map<Review>(request);

            await _dbContext.AddAsync(review, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            var accommodationUnitReview = new AccommodationUnitReview
            {
                AccommodationUnitId = id,
                ReviewId = review.Id,
            };

            await _dbContext.AddAsync(accommodationUnitReview, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<ReviewGetDto>(review);
        }

        public async Task<ImageGetDto> UpdateThumbnailImageAsync(long id, ImageCreateDto request, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var uploadedImage = await _storageService.UploadFileAsync(FileType.AccommodationUnitLogo, request.ImageFileName, request.ImageBase64, cancellationToken);

            accommodationUnit.ThumbnailImage = uploadedImage.FileName;

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<ImageGetDto>(uploadedImage);
        }

        public async Task<AccommodationUnitGetDto> AddImagesAsync(long id, List<ImageCreateDto> request, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var uploadedImages = new List<Image>();

            foreach (var item in request)
            {
                var uploadedFile = await _storageService.UploadFileAsync(FileType.AccommodationUnitLogo, item.ImageFileName, item.ImageBase64, cancellationToken);

                accommodationUnit.Images.Add(_mapper.Map<Image>(uploadedFile));
            }

            await _dbContext.AddAsync(accommodationUnit, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task RemoveImagesAsync(long id, List<long> imageIds, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var images = await _dbContext.Images.Where(x => imageIds.Contains(x.Id)).ToListAsync(cancellationToken);

            _dbContext.RemoveRange(images);

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        private Expression<Func<AccommodationUnit, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.Title;
                case "shortTile":
                    return x => x.ShortTitle;
                case "township":
                    return x => x.Township.Title;
                default:
                    return x => x.Id;
            }
        }
    }
}
