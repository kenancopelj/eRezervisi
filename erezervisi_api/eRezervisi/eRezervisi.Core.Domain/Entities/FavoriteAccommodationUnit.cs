namespace eRezervisi.Core.Domain.Entities
{
    public class FavoriteAccommodationUnit
    {
        public long AccommodationUnitId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
        public long UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
