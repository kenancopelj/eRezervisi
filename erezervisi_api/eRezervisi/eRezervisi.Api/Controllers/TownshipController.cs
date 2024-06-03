using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.Township;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("townships")]
    [ApiController]
    public class TownshipController : BaseController<TownshipController>
    {
        private readonly ITownshipService _townshipService;

        public TownshipController(ITownshipService townshipService)
        {
            _townshipService = townshipService;
        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetAllAsync([FromBody] GetAllTownshipsRequest request, CancellationToken cancellationToken)
        {
            var result = await _townshipService.GetTownshipsAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetTownshipsRequest request, CancellationToken cancellationToken)
        {
            var result = await _townshipService.GetTownshipsPagedAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
