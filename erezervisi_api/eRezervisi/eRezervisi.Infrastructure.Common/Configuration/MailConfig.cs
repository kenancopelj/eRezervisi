namespace eRezervisi.Infrastructure.Common.Configuration
{
    public class MailConfig
    {
        public string Server { get; set; } = null!;
        public int Port { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public bool SSL { get; set; }
    }
}
