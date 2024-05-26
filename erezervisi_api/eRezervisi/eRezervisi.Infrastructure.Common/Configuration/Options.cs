namespace eRezervisi.Infrastructure.Common.Configuration
{
    public class Credentials
    {
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
    }

    public class RecurringJobs
    {
        public string CheckReservations { get; set; } = null!;
    }

    public class HangfireConfiguration
    {
        public Credentials Credentials { get; set; } = null!;
        public RecurringJobs RecurringJobs { get; set; } = null!;
    }
}
