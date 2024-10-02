using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Domain.Entities
{
    public class Notification : BaseEntity<long>
    {
        public long UserId { get; set; }
        public User User { get; set; } = null!;
        public string Title { get; set; } = null!;
        public string ShortTitle { get; set; } = null!;
        public string? Description { get; set; }
        public long? AccommodationUnitId { get; set; }
        public NotificationStatus Status { get; set; }
        public NotificationType Type { get; set; }


        public Notification() { }

        public void ChangeStatus(NotificationStatus status)
        {
            Status = status;
        }
    }
}
