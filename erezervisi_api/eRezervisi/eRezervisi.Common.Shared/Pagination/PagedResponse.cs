namespace eRezervisi.Common.Shared.Pagination
{
    public class PagedResponse<T>
    {
        public long TotalItems { get; set; }
        public long TotalPages { get; set; }
        public long PageSize { get; set; }
        public List<T> Items { get; set; } = null!;
    }
}
