using eRezervisi.Api.Authorization;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [CustomAuthorize(Roles.Owner.Name)]
    [Route("dashboard")]
    [ApiController]
    public class DashboardController : BaseController<DashboardController>
    {
        private readonly IDashboardService _dashboardService;

        public DashboardController(IDashboardService dashboardService)
        {
            _dashboardService = dashboardService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAsync(CancellationToken cancellationToken)
        {
            var result = await _dashboardService.GetDashboardDataAsync(cancellationToken);

            return Ok(result);
        }
    }
}
