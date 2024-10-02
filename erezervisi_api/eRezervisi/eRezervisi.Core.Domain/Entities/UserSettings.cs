namespace eRezervisi.Core.Domain.Entities
{
    public class UserSettings
    {
        public long UserId { get; set; }
        public bool ReceiveEmails { get; set; }
        public bool ReceiveNotifications { get; set; }

        public UserSettings() { }
    }
}