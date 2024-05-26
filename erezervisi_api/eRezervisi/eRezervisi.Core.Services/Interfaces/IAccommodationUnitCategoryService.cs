using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnitCategory;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IAccommodationUnitCategoryService
    {
        Task<PagedResponse<CategoryGetDto>> GetCategoriesPagedAsync(GetCategoriesRequest request, CancellationToken cancellationToken);
        Task<GetCategoriesResponse> GetCategoriesAsync(GetAllCategoriesRequest request, CancellationToken cancellationToken);
    }
}
