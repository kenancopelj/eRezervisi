using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Interfaces;

namespace eRezervisi.Api
{
    internal class CurrentUser : ICurrentUser
    {
        public CurrentUser(IHttpContextAccessor httpContextAccessor)
        {
            if (httpContextAccessor == null) return;

            var loggedUserId = httpContextAccessor.HttpContext?.User?.FindFirst(JwtClaims.UserId)?.Value;

            UserId = long.TryParse(loggedUserId, out var userId) ? userId : -1;
        }

        public long UserId { get; }
    }
}
