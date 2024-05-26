using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using System;
using System.Security.Claims;

namespace eRezervisi.Core.Services
{
    public class JwtTokenReader : IJwtTokenReader
    {
        private readonly JwtOptions _jwtOptions;
        private readonly IHttpContextAccessor _httpContext;
        public JwtTokenReader(IOptionsSnapshot<JwtOptions> jwtOptionsSnapshot, IHttpContextAccessor httpContext)
        {
            _jwtOptions = jwtOptionsSnapshot.Value;
            _httpContext = httpContext;
        }

        public long? GetAccommodationUnitIdFromToken()
        {
            ArgumentNullException.ThrowIfNull(_httpContext.HttpContext);

            var identity = _httpContext.HttpContext.User.Identity as ClaimsIdentity;

            ArgumentNullException.ThrowIfNull(identity);

            IEnumerable<Claim> claims = identity.Claims;

            ArgumentNullException.ThrowIfNull(claims);

            var accommodationUnitIdClaim = claims.Where(x => x.Type == JwtClaims.AccommodationUnitId).FirstOrDefault();

            if (accommodationUnitIdClaim == null)
                return null;

            return long.Parse(accommodationUnitIdClaim.Value);
        }

        public string? GetRoleNameFromToken()
        {
            ArgumentNullException.ThrowIfNull(_httpContext.HttpContext);

            // Cast to ClaimsIdentity.
            var identity = _httpContext.HttpContext.User.Identity as ClaimsIdentity;

            if (identity == null)
            {
                return null;
            }

            // Gets list of claims.
            IEnumerable<Claim> claims = identity.Claims;

            if (claims == null)
            {
                return null;
            }

            var userIdClaim = claims
                .Where(x => x.Type == JwtClaims.Role)
                .FirstOrDefault();

            if (userIdClaim == null)
            {
                return null;
            }

            return userIdClaim.Value;
        }

        public string GetSessionIdFromToken()
        {
            ArgumentNullException.ThrowIfNull(_httpContext.HttpContext);

            // Cast to ClaimsIdentity.
            var identity = _httpContext.HttpContext.User.Identity as ClaimsIdentity;

            ArgumentNullException.ThrowIfNull(identity);

            // Gets list of claims.
            IEnumerable<Claim> claims = identity.Claims;

            ArgumentNullException.ThrowIfNull(claims);

            var userIdClaim = claims
                .Where(x => x.Type == JwtClaims.TokenId)
                .FirstOrDefault();

            ArgumentNullException.ThrowIfNull(userIdClaim);

            return userIdClaim.Value;
        }

        public long GetUserIdFromToken()
        {
            ArgumentNullException.ThrowIfNull(_httpContext.HttpContext);

            var identity = _httpContext.HttpContext.User.Identity as ClaimsIdentity;

            ArgumentNullException.ThrowIfNull(identity);

            IEnumerable<Claim> claims = identity.Claims;

            ArgumentNullException.ThrowIfNull(claims);

            var userIdClaim = claims.Where(x => x.Type == JwtClaims.UserId).FirstOrDefault();

            ArgumentNullException.ThrowIfNull(userIdClaim);

            return long.Parse(userIdClaim.Value);
        }
    }
}
