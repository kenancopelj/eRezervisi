namespace eRezervisi.Core.Domain.Entities
{
    public class Image : BaseEntity<long>
    {
        public string FileName { get; set; } = null!;
        public bool IsThumbnailImage { get; set; }
    }
}
