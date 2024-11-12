namespace eRezervisi.Common.Dtos.Reservation
{
    public class GetReservationsResponse
    {
        public List<ReservationGetDto> Reservations { get; set; } = new();
    }
}
