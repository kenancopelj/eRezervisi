namespace eRezervisi.Core.Services.Interfaces
{
    public interface ICacheService
    {
        void SetData(string key, object value, TimeSpan expirationTime);
        object? GetData(string key);
        void RemoveData(string key);
    }
}
