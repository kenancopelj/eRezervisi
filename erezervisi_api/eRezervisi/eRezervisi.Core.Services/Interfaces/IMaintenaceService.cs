using eRezervisi.Common.Dtos.Maintenaces;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Maintenance;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IMaintenaceService
    {
        Task<PagedResponse<MaintenanceGetDto>> GetMaintenancesPagedAsync(GetMaintenancesRequest request, CancellationToken cancellationToken);
        Task<MaintenanceGetDto> GetMaintenanceByIdAsync(long maintenanceId,  CancellationToken cancellationToken);  
        Task MarkMaintenanceAsCompletedAsync(long maintenanceId, CancellationToken cancellationToken);
    }
}
