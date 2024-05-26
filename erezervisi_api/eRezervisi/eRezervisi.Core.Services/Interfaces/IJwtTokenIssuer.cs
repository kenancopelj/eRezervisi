using eRezervisi.Common.Dtos.Auth;
using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IJwtTokenIssuer
    {
        Task<JwtTokenResponse> GenerateToken(User user);
    }
}
