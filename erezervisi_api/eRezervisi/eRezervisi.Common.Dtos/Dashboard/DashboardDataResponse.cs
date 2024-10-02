using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Dtos.Review;

namespace eRezervisi.Common.Dtos.Dashboard
{
    public class DashboardDataResponse
    {
        public int ExpectedArrivals { get; set; }
        public int AvailableAccommodationUnits { get; set; }
        public int NumberOfGuests { get; set; }
        public int NumberOfReviews { get; set; }
        public List<ReviewGetDto> LatestReviews { get; set; } = new();
        public List<ReservationGetShortDto> LatestReservations { get; set; } = new();
    }
}
