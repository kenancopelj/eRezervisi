using eRezervisi.Common.Dtos.Dashboard;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IDashboardService
    {
        Task<DashboardDataResponse> GetDashboardDataAsync(CancellationToken cancellationToken);
    }
}