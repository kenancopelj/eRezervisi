using eRezervisi.Common.Dtos.User;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Notification
{
    public class NotificationGetDto
    {
        public long UserId { get; set; }
        public UserGetShortDto User { get; set; } = null!;
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        // If NotificationType is AccommodationUnit
        public long? AccommodationUnitId { get; set; }
        // If NotificationType is Message
        public long? SenderId { get; set; }
        public NotificationStatus Status { get; set; }
        public NotificationType Type { get; set; }
    }
}
