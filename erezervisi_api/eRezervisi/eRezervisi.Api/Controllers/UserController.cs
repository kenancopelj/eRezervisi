using eRezervisi.Api.Authorization;
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
        public async Task<IActionResult> RegisterUserAsync([FromBody] UserCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CreateUserAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPut("{userId}")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> UpdateUserAsync([FromRoute] long userId, [FromBody] UserUpdateDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.UpdateUserAsync(userId, request, cancellationToken);

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
        public async Task<IActionResult> GetUserByIdAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _userService.GetUserByIdAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpGet("{id}/reviews")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> GetUserReviewsAsync(long id, CancellationToken cancellationToken)
        {
            var result = await _userService.GetUserReviewsAsync(id, cancellationToken);

            return Ok(result);
        }

        [HttpGet]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> GetUsersAsync(CancellationToken cancellationToken)
        {
            var result = await _userService.GetGuestsAsync(cancellationToken);

            return Ok(result);
        }
    }
}
