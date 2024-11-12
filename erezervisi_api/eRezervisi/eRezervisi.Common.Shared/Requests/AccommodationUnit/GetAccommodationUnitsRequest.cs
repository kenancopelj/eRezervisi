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
        public long? CantonId { get; set; }
        public long? TownshipId { get; set; }
        public bool? OneNightOnly { get; set; }
        public bool? WithPool { get; set; }
        public bool? BirthdayPartiesAllowed { get; set; }
        public bool? AlcoholAllowed { get; set; }
        public int? Capacity { get; set; }
    }
}
