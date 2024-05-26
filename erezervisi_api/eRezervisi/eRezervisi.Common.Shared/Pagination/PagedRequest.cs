namespace eRezervisi.Common.Shared.Pagination
{
    public class PagedRequest<TEntity> where TEntity : class
    {
        public long Page { get; set; }
        public long PageSize { get; set; }
        public string SearchTerm { get; set; } = string.Empty;
        public string SearchTermLower => SearchTerm.ToLower();
        public string OrderByColumn { get; set; } = string.Empty;
        public string OrderBy { get; set; } = "desc";
        public int Skip => ((int)Page - 1) * (int)PageSize;
        public OrderByDirection OrderByDirection => OrderBy == "desc" ? OrderByDirection.Desc : OrderByDirection.Asc;
    }

    public enum OrderByDirection
    {
        Desc = 1,
        Asc = 2,
    }
}

