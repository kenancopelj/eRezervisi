namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationByStatusDto
    {
        public long Id { get; set; }
        public string Code { get; set; } = null!;
        public string AccommodationUnit { get; set; } = null!;
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public int TotalPeople { get; set; }
        public int TotalDays { get; set; }
        public double TotalPrice { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
