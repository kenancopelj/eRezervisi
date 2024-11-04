using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Review;
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
using Microsoft.ML;
using Microsoft.ML.Trainers;

using Microsoft.ML.Data;
using Google.Api;

namespace eRezervisi.Core.Services
{
    public class AccommodationUnitService : IAccommodationUnitService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IStorageService _storageService;
        private readonly IBackgroundJobClient _backgroundJobClient;
        private static MLContext? _mlContext;
        private static object isLocked = new();
        private static ITransformer? _model;

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
                    (request.Scope == Domain.Authorization.ScopeType.Mobile, x => x.OwnerId != userId),
                    (request.OwnerId.HasValue, x => x.OwnerId == request.OwnerId!.Value),
                    (request.CategoryId.HasValue, x => x.AccommodationUnitCategoryId == request.CategoryId!.Value),
                    (request.Status.HasValue, x => x.Status == request.Status)
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new AccommodationUnitGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Price = (double)x.Price,
                    Note = x.Note,
                    Address = x.Address,
                    OwnerId = x.OwnerId,
                    AccommodationUnitCategory = new CategoryGetDto
                    {
                        Id = x.AccommodationUnitCategoryId,
                        Title = x.AccommodationUnitCategory.Title
                    },
                    AccommodationUnitPolicy = new Common.Dtos.AccommodationUnitPolicy.PolicyGetDto
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

        public async Task<PagedResponse<AccommodationUnitGetDto>> GetPopularAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.AccommodationUnits
                .GroupJoin(
                _dbContext.Reservations,
                unit => unit.Id,
                reservation => reservation.AccommodationUnitId,
                (unit, reservations) => new { Unit = unit, ReservationCount = reservations.Count() })
            .OrderByDescending(x => x.ReservationCount)
            .Select(x => x.Unit as AccommodationUnit)
            .AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnit>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var accommodationUnits = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnit, bool>> FilterExpression)>()
                {
                    (request.Scope == Domain.Authorization.ScopeType.Mobile, x => x.OwnerId != userId),
                    (true, x => x.Status == AccommodationUnitStatus.Active),
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new AccommodationUnitGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Price = (double)x.Price,
                    Address = x.Address,
                    Note = x.Note,
                    OwnerId = x.OwnerId,
                    AccommodationUnitCategory = new CategoryGetDto
                    {
                        Id = x.AccommodationUnitCategoryId,
                        Title = x.AccommodationUnitCategory.Title
                    },
                    AccommodationUnitPolicy = new Common.Dtos.AccommodationUnitPolicy.PolicyGetDto
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

        public async Task<PagedResponse<AccommodationUnitGetDto>> GetLatestAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.AccommodationUnits
                .OrderByDescending(x => x.CreatedAt)
                .AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnit>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var accommodationUnits = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnit, bool>> FilterExpression)>()
                {
                    (request.Scope == Domain.Authorization.ScopeType.Mobile, x => x.OwnerId != userId),
                    (true, x => x.Status == AccommodationUnitStatus.Active),
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new AccommodationUnitGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Price = (double)x.Price,
                    Note = x.Note,
                    Address = x.Address,
                    OwnerId = x.OwnerId,
                    AccommodationUnitCategory = new CategoryGetDto
                    {
                        Id = x.AccommodationUnitCategoryId,
                        Title = x.AccommodationUnitCategory.Title
                    },
                    AccommodationUnitPolicy = new Common.Dtos.AccommodationUnitPolicy.PolicyGetDto
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

        public async Task<Recommender?> GetRecommendationsByAccommodationUnitId(long accommodationUnitId, CancellationToken cancellationToken)
        {
            var entity = await _dbContext.Recommenders.FirstOrDefaultAsync(x => x.AccommodationUnitId == accommodationUnitId, cancellationToken);

            if (entity is null)
            {
                return null;
            }

            return _mapper.Map<Recommender>(entity);
        }

        private List<AccommodationUnit> Recommend(long accommodationUnitId)
        {
            lock (isLocked)
            {
                if (_mlContext == null)
                {
                    _mlContext = new MLContext();

                    var tmpData = _dbContext.Reservations.Include(x => x.AccommodationUnit).ToList();

                    var data = new List<AccommodationUnitRecommendation>();

                    foreach (var x in tmpData)
                    {
                        if (x.AccommodationUnit.ViewCount > 1)
                        {
                            var distinctItemId = tmpData.Select(y => y.AccommodationUnitId).ToList();

                            distinctItemId?.ForEach(y =>
                            {
                                var relatedItems = tmpData.Select(z => z.AccommodationUnitId).Where(z => z != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new AccommodationUnitRecommendation
                                    {
                                        AccommodationUnitId = (uint)y,
                                        CoAccommodationUnitId = (uint)z,
                                    });
                                }
                            });
                        }
                    }

                    var trainData = _mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(AccommodationUnitRecommendation.AccommodationUnitId);
                    options.MatrixRowIndexColumnName = nameof(AccommodationUnitRecommendation.CoAccommodationUnitId);
                    options.LabelColumnName = "Label";

                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;

                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = _mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    _model = est.Fit(trainData);
                }
            }

            var accommodationUnits = _dbContext.AccommodationUnits.Where(x => x.Id != accommodationUnitId).ToList();

            var predictionResult = new List<Tuple<AccommodationUnit, float>>();

            foreach (var accommodationUnit in accommodationUnits)
            {
                var predictionEngine = _mlContext.Model.CreatePredictionEngine<AccommodationUnitRecommendation, CoAccommodationUnitPrediction>(_model);

                var prediction = predictionEngine.Predict(new AccommodationUnitRecommendation
                {
                    AccommodationUnitId = (uint)accommodationUnitId,
                    CoAccommodationUnitId = (uint)accommodationUnit.Id,
                });

                predictionResult.Add(new Tuple<AccommodationUnit, float>(accommodationUnit, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return _mapper.Map<List<AccommodationUnit>>(finalResult);
        }

        public async Task<PagedResponse<Recommender>> TrainModelAsync(CancellationToken cancellationToken)
        {
            var accommodationUnits = await _dbContext.AccommodationUnits.ToListAsync(cancellationToken);
            var numberOfRecords = await _dbContext.Reservations.CountAsync(cancellationToken);

            if (accommodationUnits.Count > 4 && numberOfRecords > 8)
            {
                var recommendList = new List<Recommender>();

                foreach (var accommodationUnit in accommodationUnits)
                {
                    var recommendedAccommodationUnits = Recommend(accommodationUnit.Id);

                    var result = new Recommender
                    {
                        AccommodationUnitId = accommodationUnit.Id,
                        FirstAccommodationUnitId = recommendedAccommodationUnits[0].Id,
                        SecondAccommodationUnitId = recommendedAccommodationUnits[1].Id,
                        ThirdAccommodationUnitId = recommendedAccommodationUnits[2].Id,
                    };

                    recommendList.Add(result);
                }

                await CreateNewRecommendation(recommendList, cancellationToken);
                await _dbContext.SaveChangesAsync(cancellationToken);

                return _mapper.Map<PagedResponse<Recommender>>(recommendList);
            }
            else
            {
                throw new Exception("Not enough data to generate recommendations.");
            }
        }

        private async Task CreateNewRecommendation(List<Recommender> results, CancellationToken cancellationToken)
        {
            var existingRecommendations = await _dbContext.Recommenders.ToListAsync(cancellationToken);
            var accommodationUnitsCount = await _dbContext.AccommodationUnits.CountAsync(cancellationToken);
            var recommendationCount = await _dbContext.Recommenders.CountAsync(cancellationToken);

            if (recommendationCount != 0)
            {
                if (recommendationCount > accommodationUnitsCount)
                {
                    for (int i = 0; i < accommodationUnitsCount; i++)
                    {
                        existingRecommendations[i].AccommodationUnitId = results[i].AccommodationUnitId;
                        existingRecommendations[i].FirstAccommodationUnitId = results[i].FirstAccommodationUnitId;
                        existingRecommendations[i].SecondAccommodationUnitId = results[i].SecondAccommodationUnitId;
                        existingRecommendations[i].ThirdAccommodationUnitId = results[i].ThirdAccommodationUnitId;
                    }

                    for (int i = 0; i < recommendationCount; i++)
                    {
                        _dbContext.Recommenders.Remove(existingRecommendations[i]);
                    }
                }
                else
                {
                    for (int i = 0; i < recommendationCount; i++)
                    {
                        existingRecommendations[i].AccommodationUnitId = results[i].AccommodationUnitId;
                        existingRecommendations[i].FirstAccommodationUnitId = results[i].FirstAccommodationUnitId;
                        existingRecommendations[i].SecondAccommodationUnitId = results[i].SecondAccommodationUnitId;
                        existingRecommendations[i].ThirdAccommodationUnitId = results[i].ThirdAccommodationUnitId;
                    }

                    var num = results.Count - recommendationCount;

                    if (num > 0)
                    {
                        for (int i = results.Count - num; i < results.Count; i++)
                        {
                            await _dbContext.Recommenders.AddAsync(results[i], cancellationToken);
                        }
                    }
                }
            }
            else
            {
                await _dbContext.Recommenders.AddRangeAsync(results, cancellationToken);
            }
        }


        public async Task<AccommodationUnitGetDto> CreateAccommodationUnitAsync(AccommodationUnitCreateDto request, CancellationToken cancellationToken)
        {
            DuplicateException.ThrowIf(await _dbContext.AccommodationUnits.AnyAsync(x => x.Title == request.Title, cancellationToken));

            var ownerId = _jwtTokenReader.GetUserIdFromToken();

            var user = await _dbContext.Set<User>().FirstOrDefaultAsync(x => x.Id == ownerId);

            NotFoundException.ThrowIfNull(user);

            bool firstTimeOwner = false;

            if (user.RoleId != Roles.Owner.Id)
            {
                user.ChangeRole(Roles.Owner.Id);

                firstTimeOwner = true;
            }

            var accommodationUnit = _mapper.Map<AccommodationUnit>(request);

            accommodationUnit.OwnerId = ownerId;

            accommodationUnit.Status = firstTimeOwner ? AccommodationUnitStatus.Registered : AccommodationUnitStatus.Active;

            var uploadedImages = new List<Image>();

            foreach (var item in request.Files)
            {
                var uploadedFile = await _storageService.UploadFileAsync(item.ImageFileName, item.ImageBase64, cancellationToken);

                if (item.IsThumbnail)
                {
                    accommodationUnit.ThumbnailImage = uploadedFile.FileName;
                }

                accommodationUnit.Images.Add(new Image
                {
                    FileName = uploadedFile.FileName
                });
            }

            await _dbContext.AddAsync(accommodationUnit, cancellationToken);

            accommodationUnit.AccommodationUnitPolicy ??= _mapper.Map<AccommodationUnitPolicy>(request.Policy);

            await _dbContext.SaveChangesAsync(cancellationToken);

            if (firstTimeOwner)
            {
                _backgroundJobClient.Enqueue<INotifyService>(x => x.NotifyAboutFirstTimeOwnership(ownerId));
            }

            return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
        }

        public async Task ClearAllRecommendations(CancellationToken cancellationToken)
        {
            await _dbContext.Recommenders.ExecuteDeleteAsync(cancellationToken);
        }

        public async Task<AccommodationUnitGetDto> DeactivateAccommodationUnitAsync(long id, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var lastReservation = await _dbContext.Reservations.Where(x => x.AccommodationUnitId == id && x.Status == ReservationStatus.InProgress)
                .OrderByDescending(x => x.To)
                .FirstOrDefaultAsync(cancellationToken);

            var deactivationDate = DateOnly.FromDateTime(DateTime.Now);

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
            accommodationUnit.DeletedAt = DateTime.Now;
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

        public async Task<PagedResponse<ReviewGetDto>> GetAccommodationUnitReviewsPagedAsync(GetAccommodationUnitReviewsRequest request, CancellationToken cancellationToken)
        {
            var loggedUserId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.AccommodationUnitReviews.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnitReview>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var reviews = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnitReview, bool>> FilterExpression)>()
                {
                    (request.Scope.HasValue, x => request.Scope == Domain.Authorization.ScopeType.Application && x.AccommodationUnit.OwnerId == loggedUserId)
                },
                GetReviewsOrderByExpression(pagingRequest.OrderByColumn),
                x => new ReviewGetDto
                {
                    Id = x.Review.Id,
                    Note = x.Review.Note,
                    Title = x.Review.Title,
                    Rating = x.Review.Rating,
                }, cancellationToken);

            return reviews;
        }

        public async Task<AccommodationUnitGetDto> UpdateAccommodationUnitAsync(long id, AccommodationUnitUpdateDto request, CancellationToken cancellationToken)
        {
            try
            {


                var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

                NotFoundException.ThrowIfNull(accommodationUnit);

                DuplicateException.ThrowIf(await _dbContext.AccommodationUnits.AnyAsync(x => x.Title == request.Title && x.Id != id, cancellationToken));

                _mapper.Map<AccommodationUnit>(request);

                accommodationUnit.AccommodationUnitPolicy = _mapper.Map<AccommodationUnitPolicy>(request.Policy);

                _mapper.Map(request, accommodationUnit);

                var imagesToUpload = request.Files.Where(x => x.ImageBase64 != null).ToList();

                await AddImagesAsync(id, imagesToUpload, cancellationToken);

                if (request.Files.Any(x => x.Id != null && x.Delete))
                {
                    var imagesToRemove = request.Files.Where(x => x.Delete).Select(x => x.Id ?? 0).ToList();

                    await RemoveImagesAsync(id, imagesToRemove, cancellationToken);
                }

                await _dbContext.SaveChangesAsync(cancellationToken);

                return _mapper.Map<AccommodationUnitGetDto>(accommodationUnit);
            }
            catch (Exception ex)
            {

                throw;
            }
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

            var uploadedImage = await _storageService.UploadFileAsync(request.ImageFileName, request.ImageBase64, cancellationToken);

            accommodationUnit.ThumbnailImage = uploadedImage.FileName;

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<ImageGetDto>(uploadedImage);
        }

        public async Task ViewAccommodationUnitAsync(long accommodationUnitId, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == accommodationUnitId, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            accommodationUnit.View();

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        private async Task AddImagesAsync(long id, List<ImageUpdateDto> request, CancellationToken cancellationToken)
        {
            try
            {


                var accommodationUnit = await _dbContext.AccommodationUnits.Include(x => x.Images).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

                NotFoundException.ThrowIfNull(accommodationUnit);

                var uploadedImages = new List<Image>();

                foreach (var item in request)
                {
                    if (item.ImageFileName != null && accommodationUnit.Images.FirstOrDefault(x => x.AccommodationUnitId == id && x.FileName == item.ImageFileName) is null)
                    {
                        var uploadedFile = await _storageService.UploadFileAsync(item.ImageFileName!, item.ImageBase64!, cancellationToken);

                        accommodationUnit.Images.Add(_mapper.Map<Image>(uploadedFile));
                    }
                }

                _dbContext.Update(accommodationUnit);

                await _dbContext.SaveChangesAsync(cancellationToken);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        private async Task RemoveImagesAsync(long id, List<long> imageIds, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var images = await _dbContext.Images.Where(x => imageIds.Contains(x.Id)).ToListAsync(cancellationToken);

            var deleteThumbnailImage = images.Select(x => x.FileName).Contains(accommodationUnit.ThumbnailImage);

            if (deleteThumbnailImage)
            {
                var thumbnailImage = await _dbContext.Images.Where(x => x.FileName == accommodationUnit.ThumbnailImage).FirstAsync(cancellationToken);

                images.Add(thumbnailImage);

                accommodationUnit.ThumbnailImage = string.Empty;
            }

            _dbContext.RemoveRange(images);

            foreach (var image in images)
            {
                await _storageService.DeleteFileAsync(image.FileName, cancellationToken);
            }

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        private Expression<Func<AccommodationUnitReview, object>> GetReviewsOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.Review.Title;
                default:
                    return x => x.Review.Id;
            }
        }

        private Expression<Func<AccommodationUnit, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.Title;
                case "township":
                    return x => x.Township.Title;
                default:
                    return x => x.Id;
            }
        }
    }
}
