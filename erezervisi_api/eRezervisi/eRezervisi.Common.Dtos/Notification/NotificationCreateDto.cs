using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Notification
{
    public class NotificationCreateDto
    {
        public long UserId { get; set; }
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public long? AccommodationUnitId { get; set; }
        public NotificationType Type { get; set; }
    }
}
