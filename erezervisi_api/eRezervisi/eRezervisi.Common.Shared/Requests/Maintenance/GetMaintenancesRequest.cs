using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Shared.Requests.Maintenance
{
    public class GetMaintenancesRequest : BasePagedRequest
    {
        public MaintenacePriority? Priority { get; set; }
        public MaintenanceStatus? Status { get; set; }
    }
}
