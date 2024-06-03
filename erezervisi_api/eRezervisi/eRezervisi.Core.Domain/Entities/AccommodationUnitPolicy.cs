namespace eRezervisi.Core.Domain.Entities
{
    public class AccommodationUnitPolicy
    {
        public long AccommodationUnitId { get; set; }
        public bool AlcoholAllowed { get; set; }
        public int Capacity { get; set; }
        public bool OneNightOnly { get; set; }
        public bool BirthdayPartiesAllowed { get; set; }
        public bool HasPool { get; set; }

        public AccommodationUnitPolicy() { }
    }
}
