using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.Review;
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

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetGuestsRequest request, CancellationToken cancellationToken)
        {
            var result = await _guestService.GetGuestsPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("{guestId}/review")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> ReviewGuestAsync([FromRoute] long guestId, [FromBody] ReviewCreateDto request, CancellationToken cancellationToken)
        {
            await _guestService.CreateGuestReviewAsync(guestId, request, cancellationToken);

            return Ok();
        }
    }
}
