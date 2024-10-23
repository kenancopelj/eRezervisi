using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.FavoriteAccommodationUnit;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IAccommodationUnitService
    {
        Task<AccommodationUnitGetDto> CreateAccommodationUnitAsync(AccommodationUnitCreateDto request, CancellationToken cancellationToken);
        Task<AccommodationUnitGetDto> UpdateAccommodationUnitAsync(long id, AccommodationUnitUpdateDto request, CancellationToken cancellationToken);
        Task<PagedResponse<AccommodationUnitGetDto>> GetAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken);
        Task<AccommodationUnitGetDto> GetAccommodationUnitByIdAsync(long id, CancellationToken cancellationToken);
        Task DeleteAccommodationUnitAsync(long id, CancellationToken cancellationToken);
        Task<AccommodationUnitGetDto> ActivateAccommodationUnitAsync(long id, CancellationToken cancellationToken);
        Task<AccommodationUnitGetDto> DeactivateAccommodationUnitAsync(long id, CancellationToken cancellationToken);
        Task<PagedResponse<ReviewGetDto>> GetAccommodationUnitReviewsPagedAsync(GetAccommodationUnitReviewsRequest request, CancellationToken cancellationToken);
        Task<ReviewGetDto> CreateAccommodationUnitReviewAsync(long id, ReviewCreateDto request, CancellationToken cancellationToken);
        Task<ImageGetDto> UpdateThumbnailImageAsync(long id, ImageCreateDto request, CancellationToken cancellationToken);
        Task<PagedResponse<AccommodationUnitGetDto>> GetPopularAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken);
        Task<PagedResponse<AccommodationUnitGetDto>> GetLatestAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken);
        Task<PagedResponse<AccommodationUnitGetDto>> GetRecommendedAccommodationUnitsPagedAsync(GetAccommodationUnitsRequest request, CancellationToken cancellationToken);
    }
}
