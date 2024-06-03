using eRezervisi.Common.Dtos.FavoriteAccommodationUnit;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.FavoriteAccommodationUnit;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IFavoriteAccommodationUnitService
    {
        Task<FavoriteAccommodationUnitGetDto> AddAsync(long id, CancellationToken cancellationToken);
        Task<PagedResponse<FavoriteAccommodationUnitGetDto>> GetPagedAsync(GetFavoriteAccommodationUnitsRequest request, CancellationToken cancellationToken);
        Task RemoveAsync(long id, CancellationToken cancellationToken);
    }
}
