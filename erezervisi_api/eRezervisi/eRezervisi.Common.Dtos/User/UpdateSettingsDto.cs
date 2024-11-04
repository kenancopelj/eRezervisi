namespace eRezervisi.Common.Dtos.User
{
    public class UpdateSettingsDto 
    {
        public bool ReceiveEmails { get; set; }
        public bool ReceiveNotifications { get; set; }
        public bool MarkObjectAsUncleanAfterReservation { get; set; }
    }
}
