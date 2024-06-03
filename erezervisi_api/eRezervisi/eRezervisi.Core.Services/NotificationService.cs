using AutoMapper;
using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;

namespace eRezervisi.Core.Services
{
    public class NotificationService : INotificationService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IMapper _mapper;

        public NotificationService(eRezervisiDbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }

        public async Task SendAsync(NotificationCreateDto request, CancellationToken cancellationToken)
        {
            await Task.CompletedTask;
        }
    }
}
