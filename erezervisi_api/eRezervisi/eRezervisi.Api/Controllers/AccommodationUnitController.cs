using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("accommodation-units")]
    [ApiController]
    public class AccommodationUnitController : BaseController<AccommodationUnitController>
    {
        private readonly IAccommodationUnitService _service;

        public AccommodationUnitController(IAccommodationUnitService service)
        {
            _service = service;
        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> CreateAccommodationUnitAsync([FromBody] AccommodationUnitCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _service.CreateAccommodationUnitAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetAccommodationUnitsPagedAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
