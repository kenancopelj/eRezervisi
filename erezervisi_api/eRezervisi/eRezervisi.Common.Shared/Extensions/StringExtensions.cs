namespace eRezervisi.Common.Shared.Extensions
{
    public static class StringExtensions
    {
        public static string ToUpperFirstLetter(this string input)
        {
            if (string.IsNullOrEmpty(input)) return input;

            if (input.Length == 1) return input.ToUpper();

            string response = char.ToUpper(input[0]) + input.Substring(1).ToLower();

            return response;
        }
    }
}
