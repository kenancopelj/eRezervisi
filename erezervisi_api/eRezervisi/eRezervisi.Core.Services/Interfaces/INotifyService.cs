namespace eRezervisi.Core.Services.Interfaces
{
    public interface INotifyService
    {
        Task NotifyOwnerAboutReservationStatus(long reservationId);
        Task NotifyUsersAboutAccommodationUnitStatus(long accommodationUnitId);
        Task NotifyAboutNewMessage(long messageId);
        Task NotifyAboutFirstTimeOwnership(long userId);
        Task NotifyUserAboutUncleanObject(long accommodationUnitId);
        Task NotifyOwnerAboutNewReservation(long reservationId);
        Task NotifyGuestAboutDeclinedReservation(long reservationId);
        Task NotifyUsersAboutAccommodationUnitUpdate(long accommodationUnitId);
        Task NotifyUserAboutNewReview(long userId);
    }
}
