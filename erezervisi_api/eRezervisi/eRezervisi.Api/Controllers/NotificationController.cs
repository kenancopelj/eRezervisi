using eRezervisi.Api.Authorization;
using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("notifications")]
    [ApiController]
    public class NotificationController : BaseController<NotificationController>
    {
        private readonly INotificationService _notificationService;

        public NotificationController(INotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        [HttpPost]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> SendNotificationAsync([FromBody] NotificationCreateDto request, CancellationToken cancellationToken)
        {
            await _notificationService.SendAsync(request, cancellationToken);

            return Ok();
        }

        [HttpGet]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> GetAllAsync(CancellationToken cancellationToken)
        {
            var result = await _notificationService.GetNotificationsAsync(cancellationToken);

            return Ok(result);
        }

        [HttpPut("mark-as-read")]
        [CustomAuthorize(Roles.MobileUser.Name, Roles.Owner.Name)]
        public async Task<IActionResult> MarkAsReadAsync(CancellationToken cancellationToken)
        {
            await _notificationService.MarkAsReadAsync(cancellationToken);

            return Ok();
        }
    }
}
