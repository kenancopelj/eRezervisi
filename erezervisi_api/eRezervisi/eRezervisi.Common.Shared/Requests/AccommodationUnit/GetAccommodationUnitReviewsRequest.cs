using eRezervisi.Common.Shared.Pagination;

namespace eRezervisi.Common.Shared.Requests.AccommodationUnit
{
    public class GetAccommodationUnitReviewsRequest : BasePagedRequest
    {
        public long AccommodationUnitId { get; set; }
    }
}
