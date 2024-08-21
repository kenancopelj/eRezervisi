namespace eRezervisi.Common.Shared
{
    public static class EnumerableExtensions
    {
        public static IEnumerable<T> Randomize<T>(this IEnumerable<T> source)
        {
            Random random = new();

            return source.OrderBy<T, int>((item) => random.Next());
        }
    }
}
