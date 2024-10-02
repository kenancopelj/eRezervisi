namespace eRezervisi.Common.Dtos.UserSettings
{
    public class UserSettingsGetDto
    {
        public long UserId { get; set; }
        public bool ReceiveMails { get; set; }
        public bool ReceiveNotifications { get; set; }
    }
}
