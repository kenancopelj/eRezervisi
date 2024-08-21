using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("users")]
    [ApiController]
    public class UserController : BaseController<UserController>
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<IActionResult> RegisterAsync([FromBody] UserCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CreateUserAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{id}")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> UpdateAsync([FromRoute] long id, [FromBody] UserUpdateDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.UpdateUserAsync(id, request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{userId}/change-password")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> ChangePasswordAsync([FromRoute] long userId, [FromBody] ChangePasswordDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.ChangePasswordAsync(userId, request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{userId}/change-settings")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> ChangeSettingsAsync([FromRoute] long userId, [FromBody] UpdateSettingsDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.UpdateSettingsAsync(userId, request, cancellationToken);

            return Ok(result);
        }


        [HttpGet("{id}")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> GetByIdAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _userService.GetUserByIdAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpGet("{id}/reviews")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> GetReviewsAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _userService.GetUserReviewsAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpPost("{id}/reviews")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> CreateReviewAsync([FromRoute] long id, [FromBody] ReviewCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CreateReviewAsync(id, request, cancellationToken);

            return Ok(result);
        }

        [HttpGet("my-reviews")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> MyReviewsAsync(CancellationToken cancellationToken)
        {
            var result = await _userService.GetReviewsByUserAsync(cancellationToken);

            return Ok(result);
        }
    }
}
