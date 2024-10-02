namespace eRezervisi.Common.Dtos.Notification
{
    public class GetNotificationsResponse
    {
        public List<NotificationGetDto> Notifications { get; set; } = new();
    }
}
