namespace eRezervisi.Core.Services.Interfaces
{
    public interface IJobService
    {
        Task CheckReservationsAsync(CancellationToken cancellationToken);
        Task CompleteReservationsAsync(CancellationToken cancellationToken);
        Task CheckUsersAsync(CancellationToken cancellationToken);
        Task CheckAccommodationUnitsAsync(CancellationToken cancellationToken);
    }
}
