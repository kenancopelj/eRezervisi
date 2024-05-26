namespace eRezervisi.Core.Domain.Entities
{
    public class AccommodationUnitReview
    {
        public Review Review { get; set; } = null!;
        public long ReviewId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
        public long AccommodationUnitId { get; set; }
    }
}
