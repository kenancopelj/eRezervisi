namespace eRezervisi.Core.Services.Interfaces
{
    public interface INotifyService
    {
        Task NotifyOwnerAboutReservationStatus(long reservationId);
        Task NotifyUsersAboutAccommodationUnitStatus(long accommodationUnitId);
        Task NotifyUserAboutPasswordChange(long userId);
    }
}
