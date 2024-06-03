using eRezervisi.Common.Shared.Pagination;

namespace eRezervisi.Common.Shared.Requests.Township
{
    public class GetTownshipsRequest : BasePagedRequest
    {
        public long? CantonId { get; set; }
    }
}
