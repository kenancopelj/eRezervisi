using eRezervisi.Common.Dtos.Message;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IMessageService
    {
        Task<MessageGetDto> SendMessageAsync(long senderId, long recieverId, CancellationToken cancellationToken);
        Task<PagedResponse<MessageGetDto>> GetMyMessagesAsync(CancellationToken cancellationToken);
    }
}
