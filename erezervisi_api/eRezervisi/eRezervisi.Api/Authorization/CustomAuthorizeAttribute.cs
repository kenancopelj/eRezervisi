using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace eRezervisi.Api.Authorization
{
    public sealed class CustomAuthorizeAttribute : Attribute, IAuthorizationFilter
    {
        public readonly string[] _roles;

        public CustomAuthorizeAttribute(params string[] roles)
        {
            _roles = roles;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            try
            {
                if (context != null)
                {
                    var userId = context.HttpContext.User.FindFirst(JwtClaims.UserId)?.Value;
                    var roleName = context.HttpContext.User.FindFirst(JwtClaims.Role)?.Value;
                    var accommodationUnit = context.HttpContext.User.FindFirst(JwtClaims.AccommodationUnitId)?.Value;

                    if (!_roles.Any(x => x == roleName))
                    {
                        context.Result = new UnauthorizedResult();
                    }

                    RouteData routeData = context.RouteData;

                    if (routeData != null)
                    {
                        if (roleName == Roles.Owner.Name)
                        {
                            if (routeData.Values.ContainsKey(JwtClaims.UserId))
                            {
                                string parameterValue = routeData.Values[JwtClaims.UserId]?.ToString() ?? "";

                                if (parameterValue != userId)
                                {
                                    context.Result = new UnauthorizedResult();
                                }
                            }

                            if (routeData.Values.ContainsKey(JwtClaims.AccommodationUnitId))
                            {
                                string parameterValue = routeData.Values[JwtClaims.AccommodationUnitId]?.ToString() ?? "";

                                if (parameterValue != accommodationUnit)
                                {
                                    context.Result = new UnauthorizedResult();
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                context.Result = new UnauthorizedResult();
            }
        }
    }
}
