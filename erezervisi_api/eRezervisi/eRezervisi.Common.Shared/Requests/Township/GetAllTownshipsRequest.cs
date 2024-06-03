using eRezervisi.Common.Shared.Pagination;

namespace eRezervisi.Common.Shared.Requests.Township
{
    public class GetAllTownshipsRequest : BaseGetAllRequest
    {
        public long? CantonId { get; set; }
    }
}
