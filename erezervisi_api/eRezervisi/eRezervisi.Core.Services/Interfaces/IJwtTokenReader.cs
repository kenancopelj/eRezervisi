namespace eRezervisi.Core.Services.Interfaces
{
    public interface IJwtTokenReader
    {
        long GetUserIdFromToken();
        string GetSessionIdFromToken();
        long? GetAccommodationUnitIdFromToken();
        string? GetRoleNameFromToken();
    }
}
