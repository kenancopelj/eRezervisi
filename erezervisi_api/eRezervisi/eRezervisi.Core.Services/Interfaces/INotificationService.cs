using eRezervisi.Common.Dtos.Notification;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface INotificationService
    {
        Task<GetNotificationsResponse> GetNotificationsAsync(CancellationToken cancellationToken);
        Task MarkAsReadAsync(CancellationToken cancellationToken);
        Task SendAsync(NotificationCreateDto request, CancellationToken cancellationToken);
    }
}
