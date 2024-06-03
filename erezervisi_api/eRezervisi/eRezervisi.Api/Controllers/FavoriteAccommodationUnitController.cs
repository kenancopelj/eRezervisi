using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.FavoriteAccommodationUnit;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("favorites")]
    [ApiController]
    public class FavoriteAccommodationUnitController : BaseController<FavoriteAccommodationUnitController>
    {
        private readonly IFavoriteAccommodationUnitService _favoriteAccommodationUnitService;

        public FavoriteAccommodationUnitController(IFavoriteAccommodationUnitService service)
        {
            _favoriteAccommodationUnitService = service;
        }

        [HttpPost("{id}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> AddAsync([FromRoute] long id, CancellationToken cancellationToken)
        {
            var result = await _favoriteAccommodationUnitService.AddAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetFavoriteAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var result = await _favoriteAccommodationUnitService.GetPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpDelete("{id}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> DeleteAsync([FromRoute] long id, CancellationToken cancellationToken)
        {
            await _favoriteAccommodationUnitService.RemoveAsync(id, cancellationToken);

            return Ok();
        }
    }
}
