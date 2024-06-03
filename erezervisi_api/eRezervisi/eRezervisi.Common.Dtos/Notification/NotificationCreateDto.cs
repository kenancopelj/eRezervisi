using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Notification
{
    public class NotificationCreateDto
    {
        public long UserId { get; set; }
        public string Title { get; set; } = null!;
        public string ShortTitle { get; set; } = null!;
        public string? Description { get; set; }
    }
}
