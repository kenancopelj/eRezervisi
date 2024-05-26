using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Constants;
using Hangfire.Dashboard;
using System.IdentityModel.Tokens.Jwt;

namespace eRezervisi.Api.Authorization
{
    public class HangfireAuthorizationFilter : IDashboardAuthorizationFilter
    {
        public bool Authorize(DashboardContext context)
        {
            var httpContext = context.GetHttpContext();
            var jwtToken = String.Empty;

            if (httpContext.Request.Query.ContainsKey("jwt_token"))
            {
                jwtToken = httpContext.Request.Query["jwt_token"].FirstOrDefault();

                if (jwtToken != null)
                {
                    SetCookie(jwtToken);
                }
            }
            else
            {
                jwtToken = httpContext.Request.Cookies["_hangfireCookie"];
            }

            if (string.IsNullOrEmpty(jwtToken))
            {
                return false;
            }

            var handler = new JwtSecurityTokenHandler();
            var jwtSecurityToken = handler.ReadJwtToken(jwtToken);

            try
            {
                var roleClaim = jwtSecurityToken.ValidTo >= DateTime.UtcNow ? jwtSecurityToken.Claims.FirstOrDefault(x => x.Type == JwtClaims.Role) : null;

                return roleClaim != null && roleClaim.Value == Roles.Owner.Name;
            }
            catch (Exception)
            {
                throw;
            }

            void SetCookie(string jwtToken)
            {
                httpContext.Response.Cookies.Append("_hangfireCookie",
                    jwtToken,
                    new CookieOptions()
                    {
                        Expires = DateTime.Now.AddMinutes(5)
                    });
            }
        }
    }
}
