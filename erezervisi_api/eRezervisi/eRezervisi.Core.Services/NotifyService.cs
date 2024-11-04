using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using FirebaseAdmin.Messaging;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace eRezervisi.Core.Services
{
    public class NotifyService : INotifyService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly ILogger<NotifyService> _logger;
        private readonly IReservationService _reservationService;
        private readonly INotificationService _notificationService;

        public NotifyService(eRezervisiDbContext dbContext,
            ILogger<NotifyService> logger,
            IReservationService reservationService,
            INotificationService notificationService)
        {
            _dbContext = dbContext;
            _logger = logger;
            _reservationService = reservationService;
            _notificationService = notificationService;

        }

        public async Task NotifyAboutFirstTimeOwnership(long userId)
        {
            var notification = new NotificationCreateDto
            {
                UserId = userId,
                Title = "Novi objekat",
                ShortTitle = "Test",
                Description = "Čestitamo na Vašoj prvoj objavi objekta. Sada imate pristup desktop aplikaciji za vlasnike objekata " +
                "kojoj možete pristupiti sa svojim kredencijalima.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
        }

        public async Task NotifyAboutNewMessage(long messageId)
        {
            var message = await _dbContext.Messages.Include(x => x.Sender).FirstAsync(x => x.Id == messageId);

            NotFoundException.ThrowIfNull(message);

            var notification = new NotificationCreateDto
            {
                UserId = message.ReceiverId,
                Title = "Nova poruka",
                ShortTitle = "Test",
                Description = $"Nova poruka od korisnika {message.Sender.GetFullName()}",
                Type = NotificationType.Message,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
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

            var notification = new NotificationCreateDto
            {
                UserId = owner.Id,
                Title = "Status rezervacije",
                AccommodationUnitId = accommodationUnit.Id,
                ShortTitle = "Test",
                Description = $"Rezervacija nad Vašim objektom - {accommodationUnit.Title} je promijenila status.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
        }

        public async Task NotifyUserAboutPasswordChange(long userId)
        {
            var user = await _dbContext.Users.Include(x => x.UserCredentials).FirstAsync(x => x.Id == userId);

            NotFoundException.ThrowIfNull(user);

            var notification = new NotificationCreateDto
            {
                UserId = userId,
                Title = "Promjena lozinke",
                ShortTitle = "Test",
                Description = "Molimo ažurirajte vašu lozinku. Prošlo je više od 30 dana od posljednjeg ažuriranja",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
        }

        public async Task NotifyUserAboutUncleanObject(long accommodationUnitId)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == accommodationUnitId);

            NotFoundException.ThrowIfNull(accommodationUnit);

            var notification = new NotificationCreateDto
            {
                UserId = accommodationUnit.OwnerId,
                Title = "Zahtjev za održavanje",
                ShortTitle = "Test",
                Description = $"Rezervacija nad objektom {accommodationUnit.Title} je završena, te je kreiran nalog za održavanje pomenutog objekta.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
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
                await CancelReservationsBulkAsync(accommodationUnitId);
            }

            await NotifyUsersAboutAccommodationUnitActivity(accommodationUnitId);

            await _dbContext.SaveChangesAsync();
        }

        private async Task CancelReservationsBulkAsync(long accommodationUnitId)
        {
            var reservations = await _dbContext.Reservations
                    .Include(x => x.AccommodationUnit)
                    .Include(x => x.User).ThenInclude(x => x.UserSettings)
                    .Where(x => x.AccommodationUnitId == accommodationUnitId && x.Status == ReservationStatus.Confirmed).ToListAsync();

            foreach (var reservation in reservations)
            {
                await _reservationService.CancelReservationAsync(reservation.Id, CancellationToken.None);

                var notification = new NotificationCreateDto
                {
                    UserId = reservation.UserId,
                    AccommodationUnitId = accommodationUnitId,
                    Title = reservation.AccommodationUnit.Title,
                    ShortTitle = "Test",
                    Description = "Vaša rezervacija je otkazana zbog neaktivnosti objekta.",
                    Type = NotificationType.System
                };

                await _notificationService.SendAsync(notification, CancellationToken.None);
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
                    .Where(x => x.IsActive && x.Id != accommodationUnit.OwnerId
                    && x.UserSettings!.ReceiveEmails
                    && usersSubscribed.Contains(x.Id)).ToListAsync();


            foreach (var item in users)
            {
                var notification = new NotificationCreateDto
                {
                    UserId = item.Id,
                    Title = accommodationUnit.Title,
                    AccommodationUnitId = accommodationUnitId,
                    ShortTitle = "Test",
                    Description = accommodationUnit.Status == AccommodationUnitStatus.Active ?
                    "Objekat je ponovo dostupan za rezervacije" : "Objekat je, od danas, neaktivan za rezervacije!",
                    Type = NotificationType.AccommodationUnit,
                };

                await _notificationService.SendAsync(notification, CancellationToken.None);
            }
        }
    }
}
