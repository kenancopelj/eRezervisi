using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationGetDto
    {
        public long Id { get; set; }
        public string Code { get; set; } = null!;
        public long GuestId { get; set; }
        public string Guest { get; set; } = null!;
        public long AccommodationUnitId { get; set; }
        public string AccommodationUnit { get; set; } = null!;
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public int NumberOfChildren { get; set; }
        public int NumberOfAdults { get; set; }
        public int TotalPeople { get; set; }
        public int TotalDays { get; set; }
        public double TotalPrice { get; set; }
        public DateOnly CreatedAt { get; set; }
    }
}
