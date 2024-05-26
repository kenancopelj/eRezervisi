namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationUpdateDto
    {
        public int NumberOfAdults { get; set; }
        public int NumberOfChildren { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public string? Note { get; set; }
    }
}