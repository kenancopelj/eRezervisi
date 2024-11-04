using eRezervisi.Api.Extensions;
using eRezervisi.Api.Middleware;
using eRezervisi.Core.Services.Hubs;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Core.Services.Mapper;
using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Database;
using Hangfire;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

var logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .MinimumLevel.Error()
    .WriteTo.File(builder.Configuration["ErrorFilePath"]!, rollingInterval: RollingInterval.Day)
    .CreateLogger();

builder.Logging.ClearProviders();
builder.Logging.AddConsole();

builder.Logging.AddSerilog(logger);

builder.Services.AddControllers();

builder.Services.AddHttpContextAccessor();

AddJwtBearer();

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwagger();
builder.Services.AddDependencyInjection(builder.Configuration, builder.Environment);
builder.Services.AddFluentValidators();

builder.Services.AddDbContext<eRezervisiDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("eRezervisiDb")).UseSnakeCaseNamingConvention();
    options.EnableSensitiveDataLogging();
});

builder.Services.AddAutoMapper(typeof(MappingProfile));

builder.Services.AddHangfire(builder.Configuration);

var allowedDomains = builder.Configuration.GetSection("AllowedDomains").Get<string[]>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins", builder =>
    {
        builder.WithOrigins("*")
               .AllowAnyHeader()
               .AllowAnyMethod();
    });
});

var app = builder.Build();

app.UseMiddleware<GlobalExceptionHandler>();

app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(Path.Combine(Directory.GetCurrentDirectory(), "Uploads/Images")),
    RequestPath = "/Uploads/Images"
});

if (app.Environment.IsDevelopment() || app.Environment.IsEnvironment("Docker"))
{
    Console.WriteLine("Using Swagger");
    app.UseSwagger();
    app.UseSwaggerUI();
}

if (app.Environment.IsEnvironment("Docker"))
{
    Console.WriteLine("Migrating database");
    app.MigrateDatabase();
}

app.UseCors("*");

app.UseRouting();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.StartHangFire(app.Configuration);

app.MapHub<NotificationHub>("/notification-hub");

app.MapHub<MessageHub>("/message-hub");

TrainRecommenderModel();

app.Run();

async void TrainRecommenderModel()
{
    using (var scope = app.Services.CreateScope())
    {
        var dataContext = scope.ServiceProvider.GetRequiredService<eRezervisiDbContext>();

        if (!dataContext.Database.CanConnect())
        {
            dataContext.Database.Migrate();

            var accommodationUnitService = scope.ServiceProvider.GetRequiredService<IAccommodationUnitService>();

            try
            {
                await accommodationUnitService.TrainModelAsync();
            }
            catch (Exception)
            {

            }
        }
    }
}

void AddJwtBearer()
{
    builder.Services.Configure<JwtOptions>(builder.Configuration.GetSection("Jwt"));

    var jwtOptions = builder.Configuration.GetSection("Jwt").Get<JwtOptions>()!;

    builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(o =>
    {
        o.TokenValidationParameters = new TokenValidationParameters
        {
            ValidIssuer = jwtOptions.Issuer,
            ValidAudience = jwtOptions.Audience,
            IssuerSigningKey = new SymmetricSecurityKey
                (Encoding.UTF8.GetBytes(jwtOptions.Key)),
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true
        };
    });
}
