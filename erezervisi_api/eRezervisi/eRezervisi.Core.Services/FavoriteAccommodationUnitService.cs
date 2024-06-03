﻿using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.FavoriteAccommodationUnit;
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
                    AcoommodationUnitId = x.AccommodationUnitId,
                    AccommodationUnit = new AccommodationUnitGetDto
                    {
                        Id = x.AccommodationUnit.Id,
                        Title = x.AccommodationUnit.Title
                    }
                }, cancellationToken);

            return accommodationUnits;
        }

        public async Task RemoveAsync(long id, CancellationToken cancellationToken)
        {
            var favorite = await _dbContext.FavoriteAccommodationUnits.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

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