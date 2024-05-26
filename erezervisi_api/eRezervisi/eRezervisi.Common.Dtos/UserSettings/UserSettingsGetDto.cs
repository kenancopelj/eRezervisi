namespace eRezervisi.Common.Dtos.UserSettings
{
    public class UserSettingsGetDto
    {
        public long UserId { get; set; }
        public DateTime? SendReminderAt { get; set; }
        public bool RecieveMails { get; set; }
    }
}
