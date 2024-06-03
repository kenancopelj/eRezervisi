using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.Guest;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("guests")]
    [ApiController]
    public class GuestController : BaseController<GuestController>
    {
        private readonly IGuestService _guestService;

        public GuestController(IGuestService guestService)
        {
            _guestService = guestService;
        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetGuestsRequest request, CancellationToken cancellationToken)
        {
            var result = await _guestService.GetGuestsPagedAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
