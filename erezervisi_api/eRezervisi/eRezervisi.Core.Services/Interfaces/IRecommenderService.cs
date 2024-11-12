using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IRecommenderService
    {
        Task<List<AccommodationUnitGetDto>> GetRecommendationsByAccommodationUnitId(long accommodationUnitId, CancellationToken cancellationToken);
        Task<PagedResponse<Recommender>> TrainModelAsync(CancellationToken cancellationToken = default);
    }
}
