namespace eRezervisi.Core.Services.Interfaces
{
    public interface IHashService
    {
        string GenerateHash(string password, string passwordSalt);
        bool CompareHashes(string password, string passwordSalt, string passwordHash);
    }
}
