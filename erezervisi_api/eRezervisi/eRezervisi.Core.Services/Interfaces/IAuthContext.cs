using eRezervisi.Common.Dtos.Auth;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IAuthContext
    {
        Task<JwtTokenResponse> GenerateTokenAsync(AuthDto authDto, CancellationToken cancellationToken);
        Task<JwtTokenResponse> RefreshTokenAsync(RefreshTokenDto refreshTokenDto, CancellationToken cancellationToken);
    }
}
