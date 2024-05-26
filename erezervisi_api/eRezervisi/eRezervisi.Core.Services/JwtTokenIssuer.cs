using eRezervisi.Common.Dtos.Auth;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace eRezervisi.Core.Services
{
    public class JwtTokenIssuer : IJwtTokenIssuer
    {
        private readonly JwtOptions _jwtOptions;
        private readonly IHttpContextAccessor _httpContext;
        private readonly eRezervisiDbContext _dbContext;

        public JwtTokenIssuer(IOptionsSnapshot<JwtOptions> optionsSnapshot, IHttpContextAccessor httpContext, eRezervisiDbContext dbContext)
        {
            _jwtOptions = optionsSnapshot.Value;
            _httpContext = httpContext;
            _dbContext = dbContext;
        }

        public async Task<JwtTokenResponse> GenerateToken(User user)
        {
            var issuer = _jwtOptions.Issuer;
            var audience = _jwtOptions.Audience;
            var key = Encoding.ASCII.GetBytes(_jwtOptions.Key);
            var expiresAt = DateTime.UtcNow.Add(_jwtOptions.ExpirationTime);

            var refreshToken = Guid.NewGuid().ToString();
            var refreshTokenExpiresAt = DateTime.UtcNow.Add(_jwtOptions.RefreshTokenExpirationTime);

            string tokenId = Guid.NewGuid().ToString();

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(JwtClaims.UserId, user.Id.ToString()),
                    new Claim(JwtClaims.Role, user.Role.Name.ToString()),
                    new Claim(JwtClaims.TokenId, tokenId.ToString()),
                    new Claim(JwtRegisteredClaimNames.Sub, ""),
                    new Claim(JwtRegisteredClaimNames.Email, ""),
                    new Claim(JwtRegisteredClaimNames.Aud, audience),
                    new Claim(JwtRegisteredClaimNames.Iss, issuer),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                }),
                Expires = expiresAt,
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            if (user.Role.Id == Roles.Owner.Id)
            {
                var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.OwnerId == user.Id);

                if (accommodationUnit != null)
                {
                    tokenDescriptor.Subject.AddClaim(new Claim(JwtClaims.AccommodationUnitId, accommodationUnit.Id.ToString()));
                }
            }

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var jwtToken = tokenHandler.WriteToken(token);
            var stringToken = tokenHandler.WriteToken(token);

            return new JwtTokenResponse(true, stringToken, expiresAt, refreshToken, refreshTokenExpiresAt, user.RoleId, user.FirstName, user.LastName, user.Email, user.UserCredentials!.Username, user.Id);
        }
    }
}
