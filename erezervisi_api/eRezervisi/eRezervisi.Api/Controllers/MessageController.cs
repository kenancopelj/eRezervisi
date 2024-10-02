using eRezervisi.Common.Dtos.Message;
using eRezervisi.Common.Shared.Requests.Message;
using eRezervisi.Core.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("messages")]
    [ApiController]
    public class MessageController : BaseController<MessageController>
    {
        private readonly IMessageService _messageService;

        public MessageController(IMessageService messageService)
        {
            _messageService = messageService;
        }

        [HttpPost("paged")]
        public async Task<IActionResult> GetPagedAsync([FromBody] GetMessagesRequest request, CancellationToken cancellationToken)
        {
            var result = await _messageService.GetMyMessagesAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpPost]
        public async Task<IActionResult> SendAsync([FromBody] MessageCreateDto request, CancellationToken cancellationToken)
        {
            var result = await _messageService.SendMessageAsync(request, cancellationToken);

            return Ok(result);
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetConversationAsync([FromRoute] long userId, CancellationToken cancellationToken)
        {
            var result = await _messageService.GetConversationAsync(userId, cancellationToken);

            return Ok(result);
        }

    }
}
