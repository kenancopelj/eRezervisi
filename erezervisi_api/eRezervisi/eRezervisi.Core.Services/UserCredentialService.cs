using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Core.Services;

public class UserCredentialService : IUserCredentialService
{
    private readonly eRezervisiDbContext _db;
    private readonly IHashService _hashService;

    public UserCredentialService(eRezervisiDbContext db, IHashService hashService)
    {
        _db = db;
        _hashService = hashService;
    }

    private const int Length = 10;
    private const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+";

    public async Task GenerateCredentialAndSendEmailAsync(long userId, string username, string email)
    {
        Random random = new();

        string password = new string(Enumerable.Repeat(chars, Length).Select(s => s[random.Next(s.Length)]).ToArray());

        var user = await _db.Set<User>().FirstOrDefaultAsync(x => x.Id == userId, CancellationToken.None);

        NotFoundException.ThrowIfNull(user);

        var passwordSalt = new Guid().ToString("N");

        var passwordHash = _hashService.GenerateHash(password, passwordSalt);

        user.UserCredentials = new UserCredentials
        {
            UserId = userId,
            PasswordHash = passwordHash,
            PasswordSalt = passwordSalt,
            RefreshToken = null,
            RefreshTokenExpiresAtUtc = null,
            Username = username
        };

        await _db.SaveChangesAsync();
    }
}
