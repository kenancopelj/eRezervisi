namespace eRezervisi.Common.Dtos.User
{
    public class UpdateSettingsDto 
    {
        public bool RecieveMails { get; set; }
        public DateTime? SendReminderAt { get; set; }
    }
}
