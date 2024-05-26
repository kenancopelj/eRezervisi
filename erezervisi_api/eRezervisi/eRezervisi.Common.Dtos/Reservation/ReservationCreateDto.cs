using eRezervisi.Core.Domain.Enums;
using System.ComponentModel.DataAnnotations.Schema;

namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationCreateDto
    {
        public long AccommodationUnitId { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public string? Note { get; set; }
        public int NumberOfAdults { get; set; }
        public int NumberOfChildren { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        [NotMapped]
        public int TotalPeople => NumberOfAdults + NumberOfChildren;
    }
}
