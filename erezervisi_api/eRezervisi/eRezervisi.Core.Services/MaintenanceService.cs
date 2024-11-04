using AutoMapper;
using eRezervisi.Common.Dtos.Maintenaces;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Maintenance;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class MaintenanceService : IMaintenaceService
    {
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;

        public MaintenanceService(
            IJwtTokenReader jwtTokenReader,
            eRezervisiDbContext dbContext,
            IMapper mapper)
        {
            _jwtTokenReader = jwtTokenReader;
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task<MaintenanceGetDto> GetMaintenanceByIdAsync(long maintenanceId, CancellationToken cancellationToken)
        {
            var maintenace = await _dbContext.Maintenances.FirstOrDefaultAsync(x => x.Id == maintenanceId, cancellationToken);

            NotFoundException.ThrowIfNull(maintenace);

            return _mapper.Map<MaintenanceGetDto>(maintenace);
        }

        public async Task<PagedResponse<MaintenanceGetDto>> GetMaintenancesPagedAsync(GetMaintenancesRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.Maintenances.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Maintenance>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var maintenances = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Maintenance, bool>> FilterExpression)>()
                {
                    (request.Status.HasValue, x => x.Status == request.Status!),
                    (request.Priority.HasValue, x => x.Priority == request.Priority!),
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => _mapper.Map<MaintenanceGetDto>(x)
                , cancellationToken);

            return maintenances;
        }

        public async Task MarkMaintenanceAsCompletedAsync(long maintenanceId, CancellationToken cancellationToken)
        {
            var maintenance = await _dbContext.Maintenances.FirstOrDefaultAsync(x => x.Id == maintenanceId, cancellationToken);

            NotFoundException.ThrowIfNull(maintenance);

            maintenance.Status = Domain.Enums.MaintenanceStatus.Completed;

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        private Expression<Func<Maintenance, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "status":
                    return x => x.Status;
                case "priority":
                    return x => x.Priority;
                default:
                    return x => x.Id;
            }
        }
    }
}
