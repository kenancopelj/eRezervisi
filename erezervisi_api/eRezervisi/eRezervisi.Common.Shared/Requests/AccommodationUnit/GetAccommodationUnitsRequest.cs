using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Authorization;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Shared.Requests.AccommodationUnit
{
    public class GetAccommodationUnitsRequest : BasePagedRequest
    {
        public ScopeType Scope { get; set; } 
        public long? OwnerId { get; set; }
        public long? CategoryId { get; set; }
        public AccommodationUnitStatus? Status { get; set; }
    }
}
