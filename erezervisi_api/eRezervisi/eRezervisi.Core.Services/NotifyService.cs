using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace eRezervisi.Core.Services
{
    public class NotifyService : INotifyService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly ILogger<NotifyService> _logger;
        private readonly IReservationService _reservationService;

        public NotifyService(eRezervisiDbContext dbContext,
            ILogger<NotifyService> logger,
            IReservationService reservationService)
        {
            _dbContext = dbContext;
            _logger = logger;
            _reservationService = reservationService;
        }

        public async Task NotifyOwnerAboutReservationStatus(long reservationId)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == reservationId);

            if (reservation == null)
            {
                _logger.LogError($"Reservation with Id: {reservationId} was not found while trying to notify owner about reservation status change.");

                return;
            }

            var accommodationUnit = await _dbContext.AccommodationUnits.Include(x => x.Owner).ThenInclude(x => x.UserCredentials).FirstOrDefaultAsync(x => x.Id == reservation!.AccommodationUnitId);

            if (accommodationUnit == null)
            {
                _logger.LogError($"Accommodation unit from reservation with Id: {reservationId} was not found while trying to notify owner about reservation status change.");

                return;
            }

            var owner = accommodationUnit.Owner;

            // Todo - Send email to owners email from userCredentials

            await Task.CompletedTask;
        }

        public async Task NotifyUserAboutPasswordChange(long userId)
        {
            // Todo
            await Task.CompletedTask;
        }

        public async Task NotifyUsersAboutAccommodationUnitStatus(long accommodationUnitId)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == accommodationUnitId);

            if (accommodationUnit == null)
            {
                _logger.LogError($"Accommodation unit with Id: {accommodationUnitId} was not found while trying to notify user about accommodation unit inactivity.");

                return;
            }

            if (accommodationUnit.Status == AccommodationUnitStatus.Inactive)
            {
                await NotifyUsersAboutAccommodationUnitActivity(accommodationUnitId);
                await CancelReservationsBulkAsync(accommodationUnitId);
            }
            else
            {
                await NotifyUsersAboutAccommodationUnitActivity(accommodationUnitId);
            }

            await _dbContext.SaveChangesAsync();
        }

        private async Task CancelReservationsBulkAsync(long accommodationUnitId)
        {
            var reservations = await _dbContext.Reservations
                    .Include(x => x.User).ThenInclude(x => x.UserSettings)
                    .Where(x => x.AccommodationUnitId == accommodationUnitId && x.Status == ReservationStatus.Confirmed).ToListAsync();

            foreach (var reservation in reservations)
            {
                await _reservationService.CancelReservationAsync(reservation.Id, CancellationToken.None);
            }

            await _dbContext.SaveChangesAsync();
        }

        private async Task NotifyUsersAboutAccommodationUnitActivity(long accommodationUnitId)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == accommodationUnitId);

            if (accommodationUnit == null)
            {
                _logger.LogError($"Accommodation unit with Id: {accommodationUnitId} was not found while trying to notify user about accommodation unit activation.");

                return;
            }

            var usersSubscribed = await _dbContext.FavoriteAccommodationUnits
                .Where(x => x.AccommodationUnitId == accommodationUnitId)
                .Select(x => x.CreatedBy)
                .ToListAsync(CancellationToken.None);

            var users = await _dbContext.Users
                    .Include(x => x.UserSettings)
                    .Where(x => x.IsActive && x.Id != accommodationUnit.OwnerId && x.UserSettings!.RecieveEmails && usersSubscribed.Contains(x.Id)).ToListAsync();


            foreach (var reservation in users)
            {
                // Todo - send notification/mail
            }
        }
    }
}
