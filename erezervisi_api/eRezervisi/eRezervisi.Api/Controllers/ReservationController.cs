using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("reservations")]
    [ApiController]
    public class ReservationController : BaseController<ReservationController>
    {
        private readonly IReservationService _reservationService;

        public ReservationController(IReservationService reservationService)
        {
            _reservationService = reservationService;
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetReservationsRequest request, CancellationToken cancellationToken)
        {
            var result = await _reservationService.GetReservationPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> CreateAsync([FromBody] ReservationCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _reservationService.CreateReservationAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{id}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> UpdateAsync([FromRoute] long id, [FromBody] ReservationUpdateDto request, CancellationToken cancellationToken)
        {
            var result = await _reservationService.UpdateReservationAsync(id, request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{id}/cancel")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> CancelAsync([FromRoute] long id, CancellationToken cancellationToken)
        {
            await _reservationService.CancelReservationAsync(id, cancellationToken);

            return Ok();
        }

        [HttpPut("{id}/confirm")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> ConfirmAsync([FromRoute] long id, CancellationToken cancellationToken)
        {
            await _reservationService.ConfirmReservationAsync(id, cancellationToken);

            return Ok();
        }

        [HttpDelete("{id}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> DeleteAsync([FromRoute] long id, CancellationToken cancellationToken)
        {
            await _reservationService.DeleteReservationAsync(id, cancellationToken);

            return Ok();
        }

        [HttpPost("status")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetByStatusAsync([FromBody] GetReservationsByStatusRequest request, CancellationToken cancellationToken)
        {
            var result = await _reservationService.GetUserReservationsAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
