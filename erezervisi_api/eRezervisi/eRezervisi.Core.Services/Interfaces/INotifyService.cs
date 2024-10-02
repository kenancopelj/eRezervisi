using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface INotifyService
    {
        Task NotifyOwnerAboutReservationStatus(long reservationId);
        Task NotifyUsersAboutAccommodationUnitStatus(long accommodationUnitId);
        Task NotifyUserAboutPasswordChange(long userId);
        Task NotifyAboutNewMessage(long messageId);
        Task NotifyAboutFirstTimeOwnership(long userId);
    }
}
