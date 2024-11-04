using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("search")]
    [ApiController]
    public class SearchController : BaseController<SearchController>
    {
        private readonly ISearchService _searchService;

        public SearchController(ISearchService searchService)
        {
            _searchService = searchService;
        }

        [HttpPost]
        public async Task<IActionResult> SearchAsync([FromBody] BaseGetAllRequest request, CancellationToken cancellationToken)
        {
            var result = await _searchService.SearchAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
