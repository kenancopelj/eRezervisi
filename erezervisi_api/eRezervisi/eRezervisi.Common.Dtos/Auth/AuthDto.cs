using eRezervisi.Core.Domain.Authorization;

namespace eRezervisi.Common.Dtos.Auth
{
    public class AuthDto
    {
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public ScopeType Scope { get; set; }
    }
}
