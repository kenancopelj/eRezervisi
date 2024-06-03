namespace eRezervisi.Core.Domain.Entities
{
    public class FavoriteAccommodationUnit : BaseEntity<long>
    {
        public long AccommodationUnitId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
    }
}
