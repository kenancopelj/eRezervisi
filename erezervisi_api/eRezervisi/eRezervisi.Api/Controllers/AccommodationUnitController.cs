using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Shared.Requests.AccommodationUnit;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("accommodation-units")]
    [ApiController]
    public class AccommodationUnitController : BaseController<AccommodationUnitController>
    {
        private readonly IAccommodationUnitService _service;
        private readonly IRecommenderService _recommenderService;

        public AccommodationUnitController(IAccommodationUnitService service, IRecommenderService recommenderService)
        {
            _service = service;
            _recommenderService = recommenderService;

        }

        [HttpPost]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> CreateAsync([FromBody] AccommodationUnitCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _service.CreateAccommodationUnitAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{id}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> UpdateAsync(long id, [FromBody] AccommodationUnitUpdateDto request, CancellationToken cancellationToken)
        {
            var result = await _service.UpdateAccommodationUnitAsync(id, request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("paged")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetAccommodationUnitsPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("popular")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetMostPopularPagedAsync([FromBody] GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetPopularAccommodationUnitsPagedAsync(request, cancellationToken);

            return Ok(result);
        }


        [HttpPost("latest")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetLatestPagedAsync([FromBody] GetAccommodationUnitsRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetLatestAccommodationUnitsPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{id}/activate")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> ActivateAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _service.ActivateAccommodationUnitAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{id}/deactivate")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> DeactivateAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _service.DeactivateAccommodationUnitAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpDelete("{id}")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> DeleteAsync(long id, CancellationToken cancellationToken)
        {
            await _service.DeleteAccommodationUnitAsync(id, cancellationToken);

            return Ok();
        }

        [HttpGet("{id}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetByIdAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _service.GetAccommodationUnitByIdAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpPost("reviews")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetReviewsPagedAsync([FromBody] GetAccommodationUnitReviewsRequest request, CancellationToken cancellationToken)
        {
            var result = await _service.GetAccommodationUnitReviewsPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpGet("{accommodationUnit}/all-reviews")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> GetAllReviewsAsync(long accommodationUnit, CancellationToken cancellationToken)
        {
            var result = await _service.GetAllAccommodationUnitReviewsAsync(accommodationUnit, cancellationToken);

            return Ok(result);
        }

        [HttpPost("{id}/review")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> CreateReviewAsync([FromRoute] long id, [FromBody] ReviewCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _service.CreateAccommodationUnitReviewAsync(id, request, cancellationToken);

            return Ok(result);
        }

        [HttpGet("recommend/{accommodationUnit}")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> Recommend(long accommodationUnit, CancellationToken cancellationToken)
        {
            var result = await _recommenderService.GetRecommendationsByAccommodationUnitId(accommodationUnit, cancellationToken);

            return Ok(result);
        }

        [HttpPost("{accommodationUnit}/view")]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> ViewAsync([FromRoute] long accommodationUnit, CancellationToken cancellationToken)
        {
            await _service.ViewAccommodationUnitAsync(accommodationUnit, cancellationToken);

            return Ok();
        }
    }
}
