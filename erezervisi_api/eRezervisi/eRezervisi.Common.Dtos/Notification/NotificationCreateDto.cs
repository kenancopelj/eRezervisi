using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Notification
{
    public class NotificationCreateDto
    {
        public string Title { get; set; } = null!;
        public string Body { get; set; } = null!;
        public string? ImageUrl { get; set; }
    }
}
