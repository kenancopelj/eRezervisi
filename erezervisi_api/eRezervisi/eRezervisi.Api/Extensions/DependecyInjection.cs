using eRezervisi.Core.Services;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Api.Extensions
{
    public static class DependecyInjection
    {
        public static void AddDependencyInjection(this IServiceCollection services, IConfiguration configuration, IWebHostEnvironment webHostEnvironment)
        {
            services.Configure<HangfireConfiguration>(configuration.GetSection("Hangfire"));

            services.AddScoped<ICurrentUser, CurrentUser>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IHashService, HashService>();
            services.AddScoped<IJwtTokenIssuer, JwtTokenIssuer>();
            services.AddScoped<IJwtTokenReader, JwtTokenReader>();
            services.AddScoped<IAuthContext, AuthContext>();
            services.AddScoped<IAccommodationUnitCategoryService, AccommodationUnitCategoryService>();
            services.AddScoped<IAccommodationUnitService, AccommodationUnitService>();
            services.AddScoped<ICantonService, CantonService>();
            services.AddScoped<IIrregularityService, IrregularityService>();
            services.AddScoped<IReservationService, ReservationService>();
            services.AddScoped<IMessageService, MessageService>();
            services.AddScoped<ITownshipService, TownshipService>();
            services.AddScoped<IUserCredentialService, UserCredentialService>();
        }
    }
}
