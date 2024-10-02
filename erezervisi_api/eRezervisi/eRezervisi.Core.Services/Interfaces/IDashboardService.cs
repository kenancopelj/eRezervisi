using eRezervisi.Common.Dtos.Dashboard;
using eRezervisi.Common.Shared.Requests.Dashboard;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IDashboardService
    {
        Task<DashboardDataResponse> GetDashboardDataAsync(GetDashboardDataRequest request, CancellationToken cancellationToken);
    }
}