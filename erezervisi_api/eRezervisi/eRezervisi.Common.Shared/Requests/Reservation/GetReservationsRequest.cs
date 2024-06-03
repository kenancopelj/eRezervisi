using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Shared.Requests.Reservation
{
    public class GetReservationsRequest : BasePagedRequest
    {
        public ReservationStatus? Status { get; set; }
        public DateTime From { get; set; }
        public DateTime To { get; set; }
    }
}
