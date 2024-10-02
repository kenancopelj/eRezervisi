namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationGetShortDto
    {
        public long Id { get; set; }
        public string Guest { get; set; } = null!;
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public double TotalPrice { get; set; }
        public string AccommodationUnit { get; set; } = null!;
    }
}
