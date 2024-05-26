using eRezervisi.Common.Dtos.Auth;
using eRezervisi.Core.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("authentication")]
    [ApiController]
    public class AuthenticationController : BaseController<AuthenticationController>
    {
        private readonly IAuthContext _authContext;
        public AuthenticationController(IAuthContext authContext)
        {
            _authContext = authContext;
        }

        [HttpPost("sign-in")]
        public async Task<IActionResult> GenerateTokenAsync(AuthDto request, CancellationToken cancellationToken)
        {
            var result = await _authContext.GenerateTokenAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("refresh")]
        [Authorize]
        public async Task<IActionResult> RefreshTokenAsync(RefreshTokenDto request, CancellationToken cancellationToken)
        {
            var result = await _authContext.RefreshTokenAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
