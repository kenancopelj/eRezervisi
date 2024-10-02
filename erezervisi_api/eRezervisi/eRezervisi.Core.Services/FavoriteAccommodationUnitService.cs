using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.FavoriteAccommodationUnit;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.FavoriteAccommodationUnit;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class FavoriteAccommodationUnitService : IFavoriteAccommodationUnitService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IJwtTokenReader _jwtTokenReader;

        public FavoriteAccommodationUnitService(eRezervisiDbContext dbContext,
            IMapper mapper,
            IJwtTokenReader jwtTokenReader)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _jwtTokenReader = jwtTokenReader;
        }

        public async Task<FavoriteAccommodationUnitGetDto> AddAsync(long id, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var favorite = new FavoriteAccommodationUnit
            {
                AccommodationUnitId = id,
                CreatedBy = userId,
            };

            var alreadyFavorite = await _dbContext.FavoriteAccommodationUnits.AnyAsync(x => x.CreatedBy == userId && x.AccommodationUnitId == id);

            if (alreadyFavorite)
            {
                throw new DomainException("AlreadyInFavorites", "Objekat je već dodan u omiljene");
            }

            await _dbContext.AddAsync(favorite, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<FavoriteAccommodationUnitGetDto>(favorite);
        }

        public async Task<PagedResponse<FavoriteAccommodationUnitGetDto>> GetPagedAsync(GetFavoriteAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.FavoriteAccommodationUnits.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<FavoriteAccommodationUnit>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var accommodationUnits = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<FavoriteAccommodationUnit, bool>> FilterExpression)>()
                {
                    (!string.IsNullOrEmpty(searchTerm), x => x.AccommodationUnit.Title.ToLower().Contains(searchTerm)),
                    (true, x => x.CreatedBy == _jwtTokenReader.GetUserIdFromToken())
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new FavoriteAccommodationUnitGetDto
                {
                    Id = x.Id,
                    AccommodationUnitId = x.AccommodationUnitId,
                    AccommodationUnit = new AccommodationUnitGetDto
                    {
                        Id = x.AccommodationUnit.Id,
                        Title = x.AccommodationUnit.Title,
                        Price = x.AccommodationUnit.Price,
                        Note = x.AccommodationUnit.Note,
                        OwnerId = x.AccommodationUnit.OwnerId,
                        AccommodationUnitCategory = new CategoryGetDto
                        {
                            Id = x.AccommodationUnit.AccommodationUnitCategory.Id,
                            Title = x.AccommodationUnit.AccommodationUnitCategory.Title,
                        },
                        Township = new TownshipGetDto
                        {
                            Id = x.AccommodationUnit.Township.Id,
                            Title = x.AccommodationUnit.Township.Title,
                            CantonId = x.AccommodationUnit.Township.CantonId,
                            Canton = new CantonGetDto
                            {
                                Id = x.AccommodationUnit.Township.Canton.Id,
                                Title = x.AccommodationUnit.Township.Canton.Title,
                                ShortTitle = x.AccommodationUnit.Township.Canton.ShortTitle
                            }
                        },
                        Latitude = x.AccommodationUnit.Latitude,
                        Longitude = x.AccommodationUnit.Longitude,
                        ThumbnailImage = x.AccommodationUnit.ThumbnailImage,
                    }
                }, cancellationToken);

            return accommodationUnits;
        }

        public async Task RemoveAsync(long id, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var favorite = await _dbContext.FavoriteAccommodationUnits.FirstOrDefaultAsync(x => x.AccommodationUnitId == id && x.CreatedBy == userId, cancellationToken);

            NotFoundException.ThrowIfNull(favorite);

            _dbContext.Remove(favorite);

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        private Expression<Func<FavoriteAccommodationUnit, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.AccommodationUnit.Title;
                default:
                    return x => x.Id;
            }
        }
    }
}
