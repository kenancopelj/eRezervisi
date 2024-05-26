namespace eRezervisi.Common.Shared.Extensions
{
    public static class DateTimeExtensions
    {
        public static string FromDate(this DateTime dateTime)
        {
            return dateTime.ToString("dd.MM.yyyy.");
        }

        public static string FormatDateTime(this DateTime dateTime)
        {
            return dateTime.ToString("dd.MM.yyyy. HH:mm");
        }
    }
}
