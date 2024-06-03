namespace eRezervisi.Core.Domain.Entities
{
    public class UserSettings
    {
        public long UserId { get; set; }
        public DateTime? SendReminderAt { get; set; }
        public bool RecieveEmails { get; set; }

        public UserSettings() { }
    }
}