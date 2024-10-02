using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Common.Interfaces;
using Microsoft.AspNetCore.SignalR;

namespace eRezervisi.Core.Services.Hubs
{
    public class NotificationHub : Hub
    {
        private static readonly Dictionary<string, string> ConnectionUserMap = new Dictionary<string, string>();
        private readonly ICurrentUser _currentUser;

        public NotificationHub(ICurrentUser currentUser)
        {
            _currentUser = currentUser;
        }

        public async Task SendAsync(NotificationCreateDto notification)
        {
            await Clients.Others.SendAsync(SignalRTopics.Notification, notification.Title);
        }

        public override Task OnConnectedAsync()
        {
            var userId = _currentUser.UserId;

            if (userId != -1)
            {
                ConnectionUserMap[Context.ConnectionId] = userId.ToString();
            }

            return base.OnConnectedAsync();
        }

        public override Task OnDisconnectedAsync(Exception? exception)
        {
            ConnectionUserMap.Remove(Context.ConnectionId);
            return base.OnDisconnectedAsync(exception);
        }

        public static string GetConnectionIdForUserId(string userId)
        {
            return ConnectionUserMap.FirstOrDefault(x => x.Value == userId).Key;
        }
    }
}