using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface ITownshipService
    {
        Task<GetTownshipsResponse> GetTownshipsAsync(CancellationToken cancellationToken);
        Task<GetTownshipsResponse> GetTownshipsByCantonIdAsync(CancellationToken cancellationToken);
    }
}
