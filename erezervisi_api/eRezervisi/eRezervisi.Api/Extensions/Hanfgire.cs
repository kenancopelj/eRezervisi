using eRezervisi.Core.Services.Interfaces;
using Hangfire;
using Hangfire.SqlServer;
using Hangfire.Storage;
using HangfireBasicAuthenticationFilter;

namespace eRezervisi.Api.Extensions
{
    public static class Hanfgire
    {
        #region Services
        public static void AddHangfire(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddHangfire(conf => conf
                    .SetDataCompatibilityLevel(CompatibilityLevel.Version_180)
                    .UseSimpleAssemblyNameTypeSerializer()
                    .UseRecommendedSerializerSettings()
                    .UseSqlServerStorage(configuration.GetConnectionString("eRezervisiDb"), new SqlServerStorageOptions
                    {
                        SchemaName = "hangfire_erezervisi"
                    }));

            services.AddHangfireServer();
        }
        #endregion

        #region App
        public static void StartHangFire(this IApplicationBuilder app, IConfiguration configuration)
        {
            var username = configuration["Hangfire:Credentials:Username"];
            var password = configuration["Hangfire:Credentials:Password"];

            app.UseHangfireDashboard("/hangfire", new DashboardOptions
            {
                DashboardTitle = "eRezervisi dashboard",
                Authorization = new[]
                {
                    new HangfireCustomBasicAuthenticationFilter
                    {
                        User = username,
                        Pass = password
                    }
                }
            });

            //RecurringJob.AddOrUpdate<IJobService>("Deactivate users", x => x.DeactivateUsersAsync(CancellationToken.None), configuration.GetValue<string>("DeactiveUsersJobCron"),
            //    new RecurringJobOptions
            //    {
            //        TimeZone = TimeZoneInfo.FindSystemTimeZoneById("Europe/Belgrade")
            //    });

            //using (var connection = JobStorage.Current.GetConnection())
            //{
            //    foreach (var recurringJob in connection.GetRecurringJobs())
            //    {
            //        RecurringJob.RemoveIfExists(recurringJob.Id);
            //    }
            //}

            //using (var scope = app.ApplicationServices.CreateScope())
            //{
            //    var jobService = scope.ServiceProvider.GetRequiredService<IJobService>();

            //    var recurringJobOptions = new RecurringJobOptions
            //    {
            //        TimeZone = TimeZoneInfo.Utc,
            //        MisfireHandling = MisfireHandlingMode.Ignorable
            //    };

            //}
        }
        #endregion
    }
}
