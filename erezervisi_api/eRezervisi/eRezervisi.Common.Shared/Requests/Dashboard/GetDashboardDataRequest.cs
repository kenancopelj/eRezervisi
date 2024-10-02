using eRezervisi.Common.Shared.Pagination;

namespace eRezervisi.Common.Shared.Requests.Dashboard
{
    public class GetDashboardDataRequest
    {
        public int Month { get; set; }
        public int Year { get; set; }
    }
}
