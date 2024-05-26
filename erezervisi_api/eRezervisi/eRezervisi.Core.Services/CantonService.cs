using AutoMapper;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Canton;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class CantonService : ICantonService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;

        public CantonService(eRezervisiDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }


        public async Task<GetCantonsResponse> GetCantonsAsync(GetAllCantonsRequest request, CancellationToken cancellationToken)
        {
            var cantons = await _dbContext.Cantons
                .Where(x => string.IsNullOrEmpty(request.SearchTermLower) || x.Title.ToLower().Contains(request.SearchTermLower))
                .Select(x => new CantonGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    ShortTitle = x.ShortTitle,
                })
                .ToListAsync(cancellationToken);

            return new GetCantonsResponse
            {
                Cantons = cantons
            };
        }

        public async Task<PagedResponse<CantonGetDto>> GetCantonsPagedAsync(GetCantonsRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.Cantons.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Canton>>(request);
            var searchTerm = pagingRequest.SearchTerm;

            var cantons = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Canton, bool>> FilterExpression)>()
                {
                    (!string.IsNullOrEmpty(searchTerm), x => x.Title.ToLower().Contains(searchTerm))
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new CantonGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    ShortTitle = x.ShortTitle,
                }, cancellationToken);

            return cantons;
        }

        private Expression<Func<Canton, object>> GetOrderByExpression(string orderBy)
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
