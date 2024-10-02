using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Authorization;
namespace eRezervisi.Common.Shared.Requests.AccommodationUnit
{
    public class GetAccommodationUnitReviewsRequest : BasePagedRequest
    {
        public ScopeType? Scope { get; set; }
    }
}
