using AutoMapper;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Township;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class TownshipService : ITownshipService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;

        public TownshipService(eRezervisiDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<GetTownshipsResponse> GetTownshipsAsync(GetAllTownshipsRequest request, CancellationToken cancellationToken)
        {
            var townships = await _dbContext.Townships
                .AsNoTracking()
                .Include(x => x.Canton)
                .Where(x => (string.IsNullOrEmpty(request.SearchTerm) || x.Title.ToLower().Contains(request.SearchTermLower)) &&
                (request.CantonId.HasValue || x.CantonId == request.CantonId))
                .Select(x => new TownshipGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    CantonId = x.CantonId,
                    Canton = new Common.Dtos.Canton.CantonGetDto
                    {
                        Id = x.Canton.Id,
                        Title = x.Canton.Title,
                        ShortTitle = x.Canton.ShortTitle
                    },
                })
                .ToListAsync(cancellationToken);

            return new GetTownshipsResponse
            {
                Townships = townships
            };
        }

        public async Task<PagedResponse<TownshipGetDto>> GetTownshipsPagedAsync(GetTownshipsRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.Townships.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Township>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var townships = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Township, bool>> FilterExpression)>(),
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new TownshipGetDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    CantonId = x.CantonId,
                    Canton = new Common.Dtos.Canton.CantonGetDto
                    {
                        Id = x.CantonId,
                        Title = x.Canton.Title,
                        ShortTitle = x.Canton.ShortTitle
                    }
                }, cancellationToken);

            return townships;
        }

        private Expression<Func<Township, object>> GetOrderByExpression(string orderBy)
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
