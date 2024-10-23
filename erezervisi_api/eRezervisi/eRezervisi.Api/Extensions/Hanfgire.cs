using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
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
            using (var scope = app.ApplicationServices.CreateScope())
            {
                var jobService = scope.ServiceProvider.GetRequiredService<IJobService>();

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

                using (var connection = JobStorage.Current.GetConnection())
                {
                    foreach (var recurringJob in connection.GetRecurringJobs())
                    {
                        RecurringJob.RemoveIfExists(recurringJob.Id);
                    }
                }

                TimeZoneInfo timeZone = TimeZoneInfo.FindSystemTimeZoneById("Europe/Belgrade");

                RecurringJobOptions jobOptions = new()
                {
                    TimeZone = timeZone,
                };

                RecurringJob.AddOrUpdate<IJobService>(Jobs.CheckReservations, x => x.CheckReservationsAsync(CancellationToken.None), configuration.GetValue<string>("CheckReservationsJobCron"),
                    jobOptions);

                RecurringJob.AddOrUpdate<IJobService>(Jobs.CheckUsers, x => x.CheckUsersAsync(CancellationToken.None), configuration.GetValue<string>("CheckUsersJobCron"),
                    jobOptions);

                RecurringJob.AddOrUpdate<IJobService>(Jobs.CompleteReservations, x => x.CompleteReservationsAsync(CancellationToken.None), configuration.GetValue<string>("CompleteReservationsJobCron"),
                    jobOptions);

                RecurringJob.AddOrUpdate<IJobService>(Jobs.CheckAccommodationUnits, x => x.CheckAccommodationUnitsAsync(CancellationToken.None), configuration.GetValue<string>("CheckAccommodationUnitsJobCron"),
                    jobOptions);

                RecurringJob.AddOrUpdate<IJobService>(Jobs.RemindAboutPasswordChange, x => x.RemindAboutPasswordChange(CancellationToken.None), configuration.GetValue<string>("RemindAboutPasswordJobCron"),
                    jobOptions);
            }
        }
        #endregion
    }
}
