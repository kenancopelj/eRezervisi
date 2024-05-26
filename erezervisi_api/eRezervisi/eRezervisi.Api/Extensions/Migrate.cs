using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Api.Extensions
{
    public static class Migrate
    {
        public static void MigrateDatabase(this WebApplication app)
        {
            using (var scope = app.Services.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<eRezervisiDbContext>();

                dbContext.Database.Migrate();
            }
        }
    }
}
