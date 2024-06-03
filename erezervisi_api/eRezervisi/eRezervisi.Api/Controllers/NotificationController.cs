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
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        public async Task<IActionResult> SendNotificationAsync([FromBody] NotificationCreateDto request, CancellationToken cancellationToken)
        {
            await _notificationService.SendAsync(request, cancellationToken);

            return Ok();
        }
    }
}
