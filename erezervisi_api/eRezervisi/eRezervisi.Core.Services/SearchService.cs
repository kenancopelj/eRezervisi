using AutoMapper;
using eRezervisi.Common.Dtos.Search;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using System.Linq.Expressions;
using eRezervisi.Common.Dtos.AccommodationUnit;
using Microsoft.EntityFrameworkCore;
using eRezervisi.Common.Dtos.User;

namespace eRezervisi.Core.Services
{
    public class SearchService : ISearchService
    {
        private readonly eRezervisiDbContext _dbContext;

        public SearchService(eRezervisiDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<SearchResponse> GetPagedAsync(BaseGetAllRequest request, CancellationToken cancellationToken)
        {
            var accommodationUnits = await _dbContext.AccommodationUnits
                .AsNoTracking()
                .Where(x => x.Status == Domain.Enums.AccommodationUnitStatus.Active &&
                    (string.IsNullOrEmpty(request.SearchTerm) ||
                    x.Title.Contains(request.SearchTermLower)))
                .Select(x => new AccommodationUnitGetShortDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    Image = x.ThumbnailImage
                })
                .ToListAsync(cancellationToken);

            var users = await _dbContext.Users
                .AsNoTracking()
                .Where(x => x.IsActive &&
                    (string.IsNullOrEmpty(request.SearchTerm) ||
                    x.GetFullName().Contains(request.SearchTermLower) ||
                    x.UserCredentials!.Username.Contains(request.SearchTermLower)))
                .Select(x => new UserGetShortDto
                {
                    Id = x.Id,
                    FullName = x.GetFullName(),
                    Image = x.Image
                })
                .ToListAsync(cancellationToken);

            return new SearchResponse
            {
                AccommodationUnits = accommodationUnits,
                Users = users
            };
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
