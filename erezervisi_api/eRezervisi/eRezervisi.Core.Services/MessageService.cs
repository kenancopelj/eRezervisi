using eRezervisi.Common.Dtos.Message;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;

namespace eRezervisi.Core.Services
{
    public class MessageService : IMessageService
    {
        private readonly eRezervisiDbContext _dbContext;

        public MessageService(eRezervisiDbContext dbContext) 
        {
            _dbContext = dbContext;
        }

        public Task<PagedResponse<MessageGetDto>> GetMyMessagesAsync(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<MessageGetDto> SendMessageAsync(long senderId, long recieverId, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
