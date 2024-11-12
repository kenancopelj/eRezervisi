using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Shared.Requests.Reservation
{
    public class GetReservationsByStatusRequest
    {
        public ReservationStatus? Status { get; set; }
    }
}
