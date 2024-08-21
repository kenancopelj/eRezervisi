using AutoMapper;
using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using Google.Apis.Auth.OAuth2;

namespace eRezervisi.Core.Services
{
    public class NotificationService : INotificationService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IMapper _mapper;

        public NotificationService(eRezervisiDbContext dbContext,
            IJwtTokenReader jwtTokenReader,
            IMapper mapper)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
            _mapper = mapper;

            Initialize();
        }

        private void Initialize()
        {
            if (FirebaseApp.DefaultInstance == null)
            {
                FirebaseApp.Create(new AppOptions()
                {
                    Credential = GoogleCredential.FromFile(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "key.json"))
                });
            }
        }

        public async Task SendAsync(NotificationCreateDto request, CancellationToken cancellationToken)
        {
            var topic = $"notifications";

            var notification = new Message()
            {
                Notification = _mapper.Map<Notification>(request),
                Topic = topic
            };

            var messaging = FirebaseMessaging.DefaultInstance;
            var result = await messaging.SendAsync(notification, cancellationToken);
        }
    }
}
