using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Domain.Entities
{
    public class Reservation : BaseEntity<long>
    {
        public string Code { get; set; } = null!;
        public long UserId { get; set; }
        public User User { get; set; } = null!;
        public long AccommodationUnitId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public string? Note { get; set; }
        public ReservationStatus Status { get; set; } = ReservationStatus.Draft;
        public int NumberOfAdults { get; set; }
        public int NumberOfChildren { get; set; }
        public int TotalPeople => NumberOfAdults + NumberOfChildren;
        public int TotalDays => (To - From).Days + 1;
        public double TotalPrice { get; set; }

        public Reservation() { }

        public void ChangeStatus(ReservationStatus status)
        {
            Status = status;
        }

        public void CalculateTotalPrice(double basePrice)
        {
            TotalPrice = TotalDays * basePrice;
        }
    }
}
