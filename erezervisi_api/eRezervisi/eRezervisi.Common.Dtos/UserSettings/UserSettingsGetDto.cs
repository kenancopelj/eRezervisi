namespace eRezervisi.Common.Dtos.UserSettings
{
    public class UserSettingsGetDto
    {
        public long UserId { get; set; }
        public bool ReceiveEmails { get; set; }
        public bool ReceiveNotifications { get; set; }
        public bool MarkObjectAsUncleanAfterReservation { get; set; }
    }
}
