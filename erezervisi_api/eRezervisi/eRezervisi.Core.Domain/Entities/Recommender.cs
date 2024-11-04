namespace eRezervisi.Core.Domain.Entities
{
    public class Recommender : BaseEntity<long>
    {
        public long? AccommodationUnitId { get; set; }
        public long? FirstAccommodationUnitId { get; set; }
        public long? SecondAccommodationUnitId { get; set; }
        public long? ThirdAccommodationUnitId { get; set; }

    }
}
