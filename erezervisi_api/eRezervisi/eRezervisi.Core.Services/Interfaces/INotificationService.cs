using eRezervisi.Common.Dtos.Notification;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface INotificationService
    {
        Task SendAsync(NotificationCreateDto request, CancellationToken cancellationToken);
    }
}
