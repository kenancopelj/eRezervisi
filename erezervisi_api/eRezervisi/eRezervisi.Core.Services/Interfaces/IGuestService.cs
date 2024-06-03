using eRezervisi.Common.Dtos.Guest;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Guest;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IGuestService
    {
        Task<PagedResponse<GuestGetDto>> GetGuestsPagedAsync(GetGuestsRequest request, CancellationToken cancellationToken);
    }
}
