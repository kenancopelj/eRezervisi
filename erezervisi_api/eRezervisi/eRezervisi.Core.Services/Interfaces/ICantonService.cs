using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Canton;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface ICantonService
    {
        Task<PagedResponse<CantonGetDto>> GetCantonsPagedAsync(GetCantonsRequest request, CancellationToken cancellationToken);
        Task<GetCantonsResponse> GetCantonsAsync(GetAllCantonsRequest request, CancellationToken cancellationToken);
    }
}
