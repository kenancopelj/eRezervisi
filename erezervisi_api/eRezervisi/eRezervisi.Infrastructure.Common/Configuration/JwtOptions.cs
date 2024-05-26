namespace eRezervisi.Infrastructure.Common.Configuration;
public class JwtOptions
{
    public string Issuer { get; set; } = null!;
    public string Audience { get; set; } = null!;
    public string Key { get; set; } = null!;
    public TimeSpan ExpirationTime { get; set; }
    public TimeSpan RefreshTokenExpirationTime { get; set; }
}
