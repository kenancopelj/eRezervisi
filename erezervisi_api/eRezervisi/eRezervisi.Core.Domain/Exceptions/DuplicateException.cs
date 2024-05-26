namespace eRezervisi.Core.Domain.Exceptions
{
    public class DuplicateException : Exception
    {
        public DuplicateException(string message = "Resurs već postoji!") :base(message) { }

        public static void ThrowIf(bool value, string message = "Resurs već postoji!")
        {
            if (value)
            {
                throw new DuplicateException(message);
            }
        }
    }
}
