using System.Diagnostics.CodeAnalysis;

namespace eRezervisi.Core.Domain.Exceptions;

public class NotFoundException : Exception
{
    public NotFoundException(string message = "Resurs nije pronađen") : base(message) { }

    public static void ThrowIfNull<T>([NotNull] T obj, string message = "Resurs nije pronađen!")
    {
        if (obj == null) throw new NotFoundException(message);
    }
}
