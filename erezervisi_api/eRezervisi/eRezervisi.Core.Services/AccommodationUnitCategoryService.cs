using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnitCategory;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class AccommodationUnitCategoryService : IAccommodationUnitCategoryService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;

        public AccommodationUnitCategoryService(eRezervisiDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<GetCategoriesResponse> GetCategoriesAsync(GetAllCategoriesRequest request, CancellationToken cancellationToken)
        {
            var categories = await _dbContext.AccommodationUnitCategories
                .Where(x => string.IsNullOrEmpty(request.SearchTermLower) || x.Title.ToLower().Contains(request.SearchTermLower))
                .OrderByDescending(x => x.Id)
                .Select(x => new CategoryGetDto
                {
                    Id = x.Id,
                    Title = x.Title
                })
                .ToListAsync(cancellationToken);

            return new GetCategoriesResponse
            {
                Categories = categories
            };
        }

        public async Task<PagedResponse<CategoryGetDto>> GetCategoriesPagedAsync(GetCategoriesRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.AccommodationUnitCategories.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<AccommodationUnitCategory>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var categories = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<AccommodationUnitCategory, bool>> FilterExpression)>()
                {
                    (!string.IsNullOrEmpty(searchTerm), x => x.Title.ToLower().Contains(searchTerm))
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new CategoryGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                }, cancellationToken);

            return categories;
        }

        private Expression<Func<AccommodationUnitCategory, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.Title;
                default:
                    return x => x.Id;
            }
        }
    }
}
