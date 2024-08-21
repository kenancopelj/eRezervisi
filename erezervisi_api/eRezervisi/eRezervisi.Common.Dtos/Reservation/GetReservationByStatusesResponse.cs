namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationByStatusesResponse
    {
        public List<ReservationByStatusDto> Reservations { get; set; } = new();
    }
}
