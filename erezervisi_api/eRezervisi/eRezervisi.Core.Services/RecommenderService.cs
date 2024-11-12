using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.AccommodationUnitPolicy;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using AutoMapper;
using eRezervisi.Infrastructure.Database;
using Hangfire;

namespace eRezervisi.Core.Services
{
    public class RecommenderService : IRecommenderService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IJwtTokenReader _jwtTokenReader;
        private static MLContext? _mlContext;
        private static object isLocked = new();
        private static ITransformer? _model;

        public RecommenderService(eRezervisiDbContext dbContext,
            IMapper mapper,
            IJwtTokenReader jwtTokenReader,
            IStorageService storageService,
            IBackgroundJobClient backgroundJobClient)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _jwtTokenReader = jwtTokenReader;
        }

        public async Task<List<AccommodationUnitGetDto>> GetRecommendationsByAccommodationUnitId(long accommodationUnitId, CancellationToken cancellationToken)
        {
            var loggedUser = _jwtTokenReader.GetUserIdFromToken();

            var entity = await _dbContext.Recommenders.FirstOrDefaultAsync(x => x.AccommodationUnitId == accommodationUnitId, cancellationToken);

            if (entity is null)
            {
                return new();
            }

            var recommendedUnitIds = new List<long>();

            recommendedUnitIds.Add(entity.FirstAccommodationUnitId ?? 0);
            recommendedUnitIds.Add(entity.SecondAccommodationUnitId ?? 0);
            recommendedUnitIds.Add(entity.ThirdAccommodationUnitId ?? 0);

            var accommodationUnits = await _dbContext.AccommodationUnits
                .Where(x => recommendedUnitIds.Contains(x.Id) && x.OwnerId != loggedUser)
                .Select(x => new AccommodationUnitGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Price = x.Price,
                    Note = x.Note,
                    OwnerId = x.OwnerId,
                    AverageRating = x.AverageRating,
                    AccommodationUnitPolicy = new PolicyGetDto
                    {
                        AlcoholAllowed = x.AccommodationUnitPolicy.AlcoholAllowed,
                        BirthdayPartiesAllowed = x.AccommodationUnitPolicy.BirthdayPartiesAllowed,
                        Capacity = x.AccommodationUnitPolicy.Capacity,
                        HasPool = x.AccommodationUnitPolicy.HasPool,
                        OneNightOnly = x.AccommodationUnitPolicy.OneNightOnly,
                    },
                    AccommodationUnitCategory = new CategoryGetDto
                    {
                        Id = x.AccommodationUnitCategory.Id,
                        Title = x.AccommodationUnitCategory.Title,
                    },
                    TownshipId = x.TownshipId,
                    AccommodationUnitCategoryId = x.AccommodationUnitCategoryId,
                    Address = x.Address,
                    Images = x.Images.Select(y => new ImageGetDto
                    {
                        Id = y.Id,
                        FileName = y.FileName,
                    }).ToList(),
                    Township = new TownshipGetDto
                    {
                        Id = x.Township.Id,
                        Title = x.Township.Title,
                        CantonId = x.Township.CantonId,
                        Canton = new CantonGetDto
                        {
                            Id = x.Township.Canton.Id,
                            Title = x.Township.Canton.Title,
                            ShortTitle = x.Township.Canton.ShortTitle
                        }
                    },
                    Latitude = x.Latitude,
                    Longitude = x.Longitude,
                    ThumbnailImage = x.ThumbnailImage,
                })
            .ToListAsync(cancellationToken);

            return accommodationUnits;
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

    }
}
