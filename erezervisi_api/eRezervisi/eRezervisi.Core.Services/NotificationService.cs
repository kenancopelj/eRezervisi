using AutoMapper;
using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Services.Hubs;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Common.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Core.Services
{
    public class NotificationService : INotificationService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IMapper _mapper;
        private readonly IHubContext<NotificationHub> _hubContext;

        public NotificationService(eRezervisiDbContext dbContext,
            IJwtTokenReader jwtTokenReader,
            IMapper mapper,
            IHubContext<NotificationHub> hubContext)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
            _mapper = mapper;
            _hubContext = hubContext;
        }

        public async Task<GetNotificationsResponse> GetNotificationsAsync(CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var notifications = await _dbContext.Notifications
                .AsNoTracking()
                .Include(x => x.User)
                .Where(x => x.UserId == userId)
                .OrderByDescending(x => x.CreatedAt)
                .Select(x => new NotificationGetDto
                {
                    UserId = userId,
                    Description = x.Description,
                    Title = x.Title,
                    Status = x.Status,
                    Type = x.Type,
                    AccommodationUnitId = x.AccommodationUnitId,
                    SenderId = x.CreatedBy,
                    User = new Common.Dtos.User.UserGetShortDto
                    {
                        Id = userId,
                        FullName = x.User.GetFullName(),
                        Image = x.User.Image
                    }
                }).ToListAsync(cancellationToken);

            return new GetNotificationsResponse
            {
                Notifications = notifications
            };
        }

        public async Task MarkAsReadAsync(CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var notifications = await _dbContext.Notifications
                .Include(x => x.User)
                .Where(x => x.UserId == userId && x.Status != NotificationStatus.Read)
                .ToListAsync(cancellationToken);

            foreach (var item in notifications)
            {
                item.ChangeStatus(NotificationStatus.Read);
            }

            await _dbContext.SaveChangesAsync();
        }

        public async Task SendAsync(NotificationCreateDto request, CancellationToken cancellationToken)
        {
            var notification = _mapper.Map<Notification>(request);

            notification.Status = NotificationStatus.Unread;

            await _dbContext.Notifications.AddAsync(notification, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            await _hubContext.Clients.All.SendAsync($"{SignalRTopics.Notification}#{request.UserId}", request, cancellationToken);
        }
    }
}
