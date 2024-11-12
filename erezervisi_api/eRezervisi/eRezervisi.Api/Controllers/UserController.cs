using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.Mail;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Shared.Requests.User;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using FirebaseAdmin.Auth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("users")]
    [ApiController]
    public class UserController : BaseController<UserController>
    {
        private readonly IUserService _userService;
        private readonly IRabbitMQProducer _rabbitmqProducer;

        public UserController(IUserService userService, IRabbitMQProducer rabbitMQProducer)
        {
            _userService = userService;
            _rabbitmqProducer = rabbitMQProducer;
        }

        [HttpPost("test-rabbit-mq")]
        public IActionResult TestRabbitMQ([FromBody] MailCreateDto request)
        {
            _rabbitmqProducer.SendMessage(request);
            return Ok();
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
            await _userService.ChangePasswordAsync(userId, request, cancellationToken);

            return Ok();
        }

        [HttpPost("request-forgotten-password-code")]
        [AllowAnonymous]
        public async Task<IActionResult> RequestForgottenPasswordCodeAsync([FromBody] RequestResetPasswordCodeDto request, CancellationToken cancellationToken)
        {
            await _userService.RequestForgottenPasswordCodeAsync(request, cancellationToken);

            return Ok();
        }

        [HttpPost("check-forgotten-password-code")]
        [AllowAnonymous]
        public async Task<IActionResult> CheckForgottenPasswordCodeAsync([FromBody] CheckForgottenPasswordCodeDto request, CancellationToken cancellationToken)
        {
            await _userService.CheckForgottenPasswordCodeAsync(request, cancellationToken);

            return Ok();
        }

        [HttpPost("reset-password")]
        [AllowAnonymous]
        public async Task<IActionResult> ResetPasswordAsync([FromBody] ResetPasswordDto request, CancellationToken cancellationToken)
        {
            await _userService.ResetPasswordAsync(request, cancellationToken);

            return Ok();
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


        [HttpPost("{id}/reviews")]
        [CustomAuthorize(Roles.Owner.Name)]
        public async Task<IActionResult> CreateReviewAsync([FromRoute] long id, [FromBody] ReviewCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CreateReviewAsync(id, request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("reviews/paged")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> GetUsersReviewsPagedAsync([FromBody] GetUserReviewsRequest request, CancellationToken cancellationToken)
        {
            var result = await _userService.GetUsersReviewsPagedAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("check-username")]
        [AllowAnonymous]
        public async Task<IActionResult> CheckUsernameAsync([FromBody] CheckUsernameDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CheckUsernameAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("check-email")]
        [AllowAnonymous]
        public async Task<IActionResult> CheckEmailAsync([FromBody] CheckEmailDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CheckEmailAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost("check-phone-number")]
        [AllowAnonymous]
        public async Task<IActionResult> CheckPhoneNumberAsync([FromBody] CheckPhoneNumberDto request, CancellationToken cancellationToken)
        {
            var result = await _userService.CheckPhoneNumberAsync(request, cancellationToken);

            return Ok(result);
        }
    }
}
