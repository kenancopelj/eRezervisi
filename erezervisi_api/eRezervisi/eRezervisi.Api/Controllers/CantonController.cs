using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.Canton;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("cantons")]
    [ApiController]
    public class CantonController : BaseController<CantonController>
    {
        private readonly ICantonService _cantonService;

        public CantonController(ICantonService cantonService)
        {
            _cantonService = cantonService;
        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetAllAsync(GetAllCantonsRequest request, CancellationToken cancellationToken)
        {
            var result = await _cantonService.GetCantonsAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync(GetCantonsRequest request, CancellationToken cancellationToken)
        {
            var result = await _cantonService.GetCantonsPagedAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
