using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Township;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface ITownshipService
    {
        Task<GetTownshipsResponse> GetTownshipsAsync(GetAllTownshipsRequest request, CancellationToken cancellationToken);
        Task<PagedResponse<TownshipGetDto>> GetTownshipsPagedAsync(GetTownshipsRequest request, CancellationToken cancellationToken);
    }
}
