using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class AccommodationUnitService : IAccommodationUnitService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IJwtTokenReader _jwtTokenReader;

        public AccommodationUnitService(eRezervisiDbContext dbContext, IMapper mapper, IJwtTokenReader jwtTokenReader)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _jwtTokenReader = jwtTokenReader;

        }

        public async Task<AccommodationUnitGetDto> ActivateAccommodationUnitAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id);

            NotFoundException.ThrowIfNull(accommodationUnit);

            accommodationUnit.ChangeStatus(Domain.Enums.AccommodationUnitStatus.Active);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task<PagedResponse<AccommodationUnitGetDto>> GetAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.AccommodationUnits.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnit>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var accommodationUnits = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnit, bool>> FilterExpression)>()
                {
                    (!string.IsNullOrEmpty(searchTerm), x => x.Title.ToLower().Contains(searchTerm))
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new AccommodationUnitGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Price = (double)x.Price,
                    Note = x.Note,
                    CategoryTitle = x.AccommodationUnitCategory.Title,
                    Policy = new Common.Dtos.AccommodationUnitPolicy.PolicyGetDto
                    {
                        AlcoholAllowed = x.AccommodationUnitPolicy.AlcoholAllowed,
                        Capacity = x.AccommodationUnitPolicy.Capacity,
                        BirthdayPartiesAllowed = x.AccommodationUnitPolicy.BirthdayPartiesAllowed,
                        HasPool = x.AccommodationUnitPolicy.HasPool,
                        OneNightOnly = x.AccommodationUnitPolicy.OneNightOnly,
                    },
                    TownshipTitle = x.Township.Title,
                    Latitude = x.Latitude,
                    Longitude = x.Longitude,
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

            var image = new Image
            {
                FileName = request.FileName,
                IsThumbnailImage = true
            };

            await _dbContext.AddAsync(image, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            var accommodationUnit = _mapper.Map<AccommodationUnit>(request);

            accommodationUnit.OwnerId = ownerId;

            accommodationUnit.ThumbnailImageId = image.Id;

            await _dbContext.AddAsync(accommodationUnit, cancellationToken);

            accommodationUnit.AccommodationUnitPolicy ??= _mapper.Map<AccommodationUnitPolicy>(request.Policy);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task<AccommodationUnitGetDto> DeactivateAccommodationUnitAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            accommodationUnit.ChangeStatus(Domain.Enums.AccommodationUnitStatus.Inactive);

            await _dbContext.SaveChangesAsync(cancellationToken);

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

            await Task.CompletedTask;
        }

        public async Task<AccommodationUnitGetDto> GetAccommodationUnitByIdAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
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

            if (request.FileName != null)
            {
                var image = new Image
                {
                    FileName = request.FileName,
                    IsThumbnailImage = true
                };

                await _dbContext.AddAsync(image, cancellationToken);
                await _dbContext.SaveChangesAsync(cancellationToken);

                accommodationUnit.ThumbnailImageId = image.Id;
            }

            _mapper.Map<AccommodationUnit>(request);

            accommodationUnit.AccommodationUnitPolicy ??= _mapper.Map<AccommodationUnitPolicy>(request.Policy);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
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
