using System.Text.Json.Serialization;

namespace eRezervisi.Common.Shared.Pagination
{
    public class BasePagedRequest
    {
        public long Page { get; set; }
        public long PageSize { get; set; }
        public string SearchTerm { get; set; } = string.Empty;
        public string OrderByColumn { get; set; } = string.Empty;
        public string OrderBy { get; set; } = "desc";
    }

    public class BaseGetAllRequest
    {
        public string SearchTerm { get; set; } = string.Empty;
        [JsonIgnore]
        public string SearchTermLower => SearchTerm.ToLower();
    }
}
