using eRezervisi.Core.Services.Interfaces;
using System.Security.Cryptography;
using System.Text;

namespace eRezervisi.Core.Services
{
    public class HashService : IHashService
    {
        public string GenerateHash(string password, string passwordSalt)
        {
            using var sha256 = SHA256.Create();

            var passKey = $"{password}{passwordSalt}";

            var hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(passKey));

            var sBuilder = new StringBuilder();

            foreach (var hashByte in hashBytes)
            {

                sBuilder.Append(hashByte.ToString("x2"));
            }

            return sBuilder.ToString();
        }

        public bool CompareHashes(string password, string passwordSalt, string passwordHash)
        {
            using var sha256 = SHA256.Create();

            var passKey = $"{password}{passwordSalt}";

            var hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(passKey));

            var sBuilder = new StringBuilder();

            foreach (var hashByte in hashBytes)
            {

                sBuilder.Append(hashByte.ToString("x2"));
            }

            var generatedHash = sBuilder.ToString();

            return generatedHash == passwordHash;
        }

    }
}
