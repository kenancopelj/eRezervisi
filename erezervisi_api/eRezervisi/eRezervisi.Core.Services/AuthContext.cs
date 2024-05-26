using eRezervisi.Common.Dtos.Auth;
using eRezervisi.Common.Shared;
using eRezervisi.Core.Domain.Authorization;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace eRezervisi.Core.Services
{
    public class AuthContext : IAuthContext
    {
        private readonly IJwtTokenIssuer _jwtTokenIssuer;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IHashService _hashService;
        private readonly eRezervisiDbContext _dbContext;
        private readonly IHttpContextAccessor _httpContext;
        private readonly ILogger<AuthContext> _logger;

        public AuthContext(
            IJwtTokenIssuer jwtTokenIssuer,
            IJwtTokenReader jwtTokenReader,
            IHashService hashService,
            eRezervisiDbContext dbContext,
            IHttpContextAccessor httpContext,
            ILogger<AuthContext> logger)
        {
            _jwtTokenIssuer = jwtTokenIssuer;
            _jwtTokenReader = jwtTokenReader;
            _hashService = hashService;
            _dbContext = dbContext;
            _httpContext = httpContext;
            _logger = logger;
        }

        public async Task<JwtTokenResponse> GenerateTokenAsync(AuthDto request, CancellationToken cancellationToken)
        {
            try
            {
                var user = await _dbContext.Users.Include(x => x.Role)
                                                 .FirstOrDefaultAsync(x => x.UserCredentials!.Username == request.Username, cancellationToken);

                if (user is { } && user.IsActive)
                {
                    if (_hashService.CompareHashes(request.Password, user.UserCredentials!.PasswordSalt, user.UserCredentials!.PasswordHash))
                    {

                        bool enabledLogin = true;

                        if (_httpContext != null && _httpContext.HttpContext != null && request.Scope == ScopeType.Mobile)
                        {
                            if (user.Role.Id != Roles.MobileUser.Id)
                            {
                                enabledLogin = false;
                            }
                        }
                        else
                        {
                            if (user.Role.Id != Roles.Owner.Id)
                            {
                                enabledLogin = false;
                            }
                        }

                        if (!enabledLogin)
                        {
                            throw new DomainException("disabledLogin", "Nemate pristup aplikaciji!");
                        }

                        var jwtCredentials = await _jwtTokenIssuer.GenerateToken(user);

                        user.UserCredentials.SetRefreshToken(jwtCredentials.RefreshToken!, jwtCredentials.RefreshTokenExpiresAtUtc!.Value);

                        await _dbContext.SaveChangesAsync(cancellationToken);

                        return jwtCredentials;
                    }
                    else
                    {
                        throw new DomainException("invalidCredentials", "Neispravni kredencijali!");
                    }
                }
                else if (user is { } && !user.IsActive)
                {
                    throw new DomainException("userNotActive", "Korisnički nalog nije aktivan!");
                }

                throw new DomainException("invalidCredentials", "Neispravni kredencijali!");

            }
            catch (Exception ex)
            {
                _logger.LogError($"\n{ex.Message} #-# {ex.InnerException?.Message} #-# {ex.StackTrace}\n");

                throw;
            }
        }

        public async Task<JwtTokenResponse> RefreshTokenAsync(RefreshTokenDto refreshTokenDto, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var user = await _dbContext.Users.Include(x => x.Role)
                .FirstOrDefaultAsync(x => x.Id == userId, cancellationToken);

            if (user is { } && refreshTokenDto.Token == user.UserCredentials?.RefreshToken)
            {
                var jwtCredentials = await _jwtTokenIssuer.GenerateToken(user);

                user.UserCredentials.SetRefreshToken(jwtCredentials.RefreshToken!, jwtCredentials.RefreshTokenExpiresAtUtc!.Value);

                await _dbContext.SaveChangesAsync(cancellationToken);

                return jwtCredentials;
            }
            else if (user is { } && !user.IsActive)
            {
                throw new DomainException("userNotActive", "Korisnički nalog nije aktivan!");
            }

            throw new DomainException("userNotActive", "Sesija istekla!");
        }
    }
}
