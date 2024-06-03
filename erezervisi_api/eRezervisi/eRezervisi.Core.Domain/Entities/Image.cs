namespace eRezervisi.Core.Domain.Entities
{
    public class Image : BaseEntity<long>
    {
        public string FileName { get; set; } = null!;
        public long AccommodationUnitId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
    }
}
