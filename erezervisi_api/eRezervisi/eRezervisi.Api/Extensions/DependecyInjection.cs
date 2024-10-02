using eRezervisi.Core.Services;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Interfaces;

namespace eRezervisi.Api.Extensions
{
    public static class DependecyInjection
    {
        public static void AddDependencyInjection(this IServiceCollection services, IConfiguration configuration, IWebHostEnvironment webHostEnvironment)
        {
            services.Configure<HangfireConfiguration>(configuration.GetSection("Hangfire"));
            services.Configure<StorageOptions>(configuration.GetSection("Storage"));
            services.Configure<MailConfig>(configuration.GetSection("MailConfig"));

            services.AddSignalR();

            services.AddHttpContextAccessor();

            services.AddScoped<ICurrentUser, CurrentUser>();
            services.AddScoped<IJobService, JobService>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IHashService, HashService>();
            services.AddScoped<IJwtTokenIssuer, JwtTokenIssuer>();
            services.AddScoped<IJwtTokenReader, JwtTokenReader>();
            services.AddScoped<IAuthContext, AuthContext>();
            services.AddScoped<IAccommodationUnitCategoryService, AccommodationUnitCategoryService>();
            services.AddScoped<IAccommodationUnitService, AccommodationUnitService>();
            services.AddScoped<ICantonService, CantonService>();
            services.AddScoped<IReservationService, ReservationService>();
            services.AddScoped<IMessageService, MessageService>();
            services.AddScoped<ITownshipService, TownshipService>();
            services.AddScoped<IUserCredentialService, UserCredentialService>();
            services.AddScoped<IStorageService, StorageService>();
            services.AddScoped<IGuestService, GuestService>();
            services.AddScoped<INotifyService, NotifyService>();
            services.AddScoped<IFavoriteAccommodationUnitService, FavoriteAccommodationUnitService>();
            services.AddScoped<INotificationService, NotificationService>();
            services.AddScoped<IRabbitMQProducer, RabbitMQProducer>();
            services.AddScoped<IDashboardService, DashboardService>();
        }
    }
}
