namespace eRezervisi.Common.Dtos.AccommodationUnitPolicy
{
    public class PolicyGetDto
    {
        public bool AlcoholAllowed { get; set; }
        public int Capacity { get; set; }
        public bool OneNightOnly { get; set; }
        public bool BirthdayPartiesAllowed { get; set; }
        public bool HasPool { get; set; }
    }
}
