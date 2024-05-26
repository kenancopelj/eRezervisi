namespace eRezervisi.Core.Services.Interfaces
{
    public interface IJobService
    {
        Task DeactivateUsersAsync(CancellationToken cancellationToken);
    }
}
