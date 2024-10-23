using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.Statistics;
using eRezervisi.Common.Shared.Requests.Township;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("statistics")]
    [ApiController]
    public class StatisticsController : BaseController<StatisticsController>
    {
        private readonly IStatisticsService _statisticsService;

        public StatisticsController(IStatisticsService statisticsService)
        {
            _statisticsService = statisticsService;
        }

        [HttpPost("reservations-monthly")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetReservationsMonthlyAsync([FromBody] GetReservationsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            var result = await _statisticsService.GetReservationByYearAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("guests-monthly")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetGuestsMonthlyAsync([FromBody] GetGuestsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            var result = await _statisticsService.GetGuestsByYearAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
