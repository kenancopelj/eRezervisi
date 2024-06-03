using eRezervisi.Api.Authorization;
using eRezervisi.Common.Shared.Requests.AccommodationUnitCategory;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("categories")]
    [ApiController]
    public class CategoryController : BaseController<CategoryController>
    {
        private readonly IAccommodationUnitCategoryService _service;

        public CategoryController(IAccommodationUnitCategoryService service)
        {
            _service = service;
        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetAllAsync([FromBody] GetAllCategoriesRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetCategoriesAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetCategoriesRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetCategoriesPagedAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
