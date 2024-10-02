using eRezervisi.Common.Dtos.Message;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Message;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IMessageService
    {
        Task<PagedResponse<MessageGetDto>> GetMyMessagesAsync(GetMessagesRequest request, CancellationToken cancellationToken);
        Task<MessageGetDto> SendMessageAsync(MessageCreateDto request, CancellationToken cancellationToken);
        Task<GetMessagesResponse> GetConversationAsync(long senderId, CancellationToken cancellationToken);
    }
}
