using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.Maintenance;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("maintenances")]
    [ApiController]
    public class MaintenacesController : BaseController<MaintenacesController>
    {
        private readonly IMaintenaceService _maintenaceService;

        public MaintenacesController(IMaintenaceService maintenaceService)
        {
            _maintenaceService = maintenaceService;
        }

        [HttpPut("{id}")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> MarkAsCompletedAsync(long id, CancellationToken cancellationToken)
        {
            await _maintenaceService.MarkMaintenanceAsCompletedAsync(id, cancellationToken);

            return Ok();
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetMaintenancesRequest request, CancellationToken cancellationToken)
        {
            var result = await _maintenaceService.GetMaintenancesPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpGet("{id}")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> GetByIdAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _maintenaceService.GetMaintenanceByIdAsync(id, cancellationToken);

            return Ok(result);
        }
    }
}
