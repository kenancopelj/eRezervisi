namespace eRezervisi.Common.Dtos.AccommodationUnit
{
    public class RecommendedItemsGetDto
    {
        public long AccommodationUnitId { get; set; }
        public int ReservationsCount { get; set; }
        public double AverageRating { get; set; }
        public int ViewCount { get; set; }
        public float Price { get; set; }
    }
}
