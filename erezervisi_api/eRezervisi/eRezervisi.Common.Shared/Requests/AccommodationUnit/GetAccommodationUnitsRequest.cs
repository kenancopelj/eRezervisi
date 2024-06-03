using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Authorization;

namespace eRezervisi.Common.Shared.Requests.AccommodationUnit
{
    public class GetAccommodationUnitsRequest : BasePagedRequest
    {
        public ScopeType Scope { get; set; } 
        public long? OwnerId { get; set; }
        public long? CategoryId { get; set; }
    }
}
