namespace eRezervisi.Core.Services.Interfaces;

public interface IUserCredentialService
{
    Task GenerateCredentialAndSendEmailAsync(long userId, string username, string email);
}
