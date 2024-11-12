using eRezervisi.Common.Dtos.Mail;
using eRezervisi.Common.Dtos.Notification;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace eRezervisi.Core.Services
{
    public class NotifyService : INotifyService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly ILogger<NotifyService> _logger;
        private readonly IReservationService _reservationService;
        private readonly INotificationService _notificationService;
        private readonly IRabbitMQProducer _rabbitMQProducer;
        private readonly MailConfig _mailConfig;

        public NotifyService(eRezervisiDbContext dbContext,
            ILogger<NotifyService> logger,
            IReservationService reservationService,
            INotificationService notificationService,
            IRabbitMQProducer rabbitMQProducer,
            IOptionsSnapshot<MailConfig> mailConfig)
        {
            _dbContext = dbContext;
            _logger = logger;
            _reservationService = reservationService;
            _notificationService = notificationService;
            _rabbitMQProducer = rabbitMQProducer;
            _mailConfig = mailConfig.Value;
        }

        public async Task NotifyAboutFirstTimeOwnership(long userId)
        {
            var user = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == userId && x.IsActive);

            if (user == null)
            {
                _logger.LogError($"User with Id: {userId} was not found while trying to notify owner about first time ownership.");

                return;
            }

            var notification = new NotificationCreateDto
            {
                UserId = userId,
                Title = "Novi objekat",
                Description = "Čestitamo na Vašoj prvoj objavi objekta. Sada imate pristup desktop aplikaciji za vlasnike objekata " +
                "kojoj možete pristupiti sa svojim kredencijalima.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);

            if (user.UserSettings!.ReceiveEmails)
            {
                var mail = new MailCreateDto
                {
                    Subject = "Postali ste vlasnik!",
                    Content = "Čestitamo na Vašoj prvoj objavi objekta. Sada imate pristup desktop aplikaciji za vlasnike objekata " +
                    "kojoj možete pristupiti sa svojim kredencijalima.",
                    Recipient = user.Email,
                    Sender = _mailConfig.Username
                };

                _rabbitMQProducer.SendMessage(mail);
            }
        }

        public async Task NotifyAboutNewMessage(long messageId)
        {
            var message = await _dbContext.Messages.Include(x => x.Sender).FirstAsync(x => x.Id == messageId);

            NotFoundException.ThrowIfNull(message);

            var notification = new NotificationCreateDto
            {
                UserId = message.ReceiverId,
                Title = "Nova poruka",
                Description = $"Nova poruka od korisnika {message.Sender.GetFullName()}",
                Type = NotificationType.Message,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
        }

        public async Task NotifyOwnerAboutNewReservation(long reservationId)
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
                Title = "Nova rezervacija",
                AccommodationUnitId = accommodationUnit.Id,
                Description = $"Kreirana je nova rezervacija nad Vašim objektom - {accommodationUnit.Title}.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);
        }

        public async Task NotifyGuestAboutDeclinedReservation(long reservationId)
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

            var user = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == reservation.UserId && x.IsActive);

            if (user == null)
            {
                _logger.LogError($"User Id: {reservationId} was not found while trying to notify guest about declined reservation.");

                return;
            }

            var notification = new NotificationCreateDto
            {
                UserId = reservation.UserId,
                Title = "Nova rezervacija",
                AccommodationUnitId = accommodationUnit.Id,
                Description = $"Vaša rezervacija nad objektom {accommodationUnit.Title} je odbijena.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);

            if (user.UserSettings!.ReceiveEmails)
            {
                var mail = new MailCreateDto
                {
                    Subject = $"Odbijena rezervacija",
                    Content = $"Vaša rezervacija nad objektom {accommodationUnit.Title}, u periodu od {reservation.From.ToString("dd.MM.yyyy")} do {reservation.To.ToString("dd.MM.yyyy")} je odbijena.",
                    Recipient = user.Email,
                    Sender = _mailConfig.Username
                };

                _rabbitMQProducer.SendMessage(mail);
            }
        }

        public async Task NotifyOwnerAboutReservationStatus(long reservationId)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == reservationId);

            if (reservation == null)
            {
                _logger.LogError($"Reservation with Id: {reservationId} was not found while trying to notify owner about reservation status change.");

                return;
            }

            var accommodationUnit = await _dbContext.AccommodationUnits
                .Include(x => x.Owner)
                .ThenInclude(x => x.UserCredentials)
                .FirstOrDefaultAsync(x => x.Id == reservation!.AccommodationUnitId);

            if (accommodationUnit == null)
            {
                _logger.LogError($"Accommodation unit from reservation with Id: {reservationId} was not found while trying to notify owner about reservation status change.");

                return;
            }

            var owner = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == accommodationUnit.OwnerId && x.IsActive);

            if (owner == null)
            {
                _logger.LogError($"User with Id: {accommodationUnit.OwnerId} was not found while trying to notify owner about reservation status change.");

                return;
            }

            var notification = new NotificationCreateDto
            {
                UserId = owner.Id,
                Title = "Status rezervacije",
                AccommodationUnitId = accommodationUnit.Id,
                Description = $"Rezervacija nad Vašim objektom - {accommodationUnit.Title} je promijenila status.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);

            if (owner.UserSettings!.ReceiveEmails)
            {
                var mail = new MailCreateDto
                {
                    Subject = $"Promjena statuse rezervacije nad Vašim objektom",
                    Content = $"Rezervacija nad Vašim objektom, {accommodationUnit.Title}, u periodu od {reservation.From.ToString("dd.MM.yyyy")} do {reservation.To.ToString("dd.MM.yyyy")} je promijenila status.",
                    Recipient = owner.Email,
                    Sender = _mailConfig.Username
                };

                _rabbitMQProducer.SendMessage(mail);
            }
        }

        public async Task NotifyUserAboutUncleanObject(long accommodationUnitId)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == accommodationUnitId);

            if (accommodationUnit == null)
            {
                _logger.LogError($"Accommodation unit with Id: {accommodationUnitId} was not found while trying to notify owner about unclean object.");

                return;
            }

            var owner = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == accommodationUnit.OwnerId);

            if (accommodationUnit == null)
            {
                _logger.LogError($"User with Id: {accommodationUnit!.OwnerId} was not found while trying to notify owner about unclean object.");

                return;
            }

            var notification = new NotificationCreateDto
            {
                UserId = accommodationUnit.OwnerId,
                Title = "Zahtjev za održavanje",
                Description = $"Rezervacija nad objektom {accommodationUnit.Title} je završena, te je kreiran nalog za održavanje pomenutog objekta.",
                Type = NotificationType.System,
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);

            if (owner!.UserSettings!.ReceiveEmails)
            {
                var mail = new MailCreateDto
                {
                    Subject = $"Zahtjev za održavanje - {accommodationUnit.Title}",
                    Content = $"Rezervacija nad Vašim objektom, {accommodationUnit.Title} je završena, te je kreiran nalog za održavanje pomenutog objekta.",
                    Recipient = owner.Email,
                    Sender = _mailConfig.Username
                };

                _rabbitMQProducer.SendMessage(mail);
            }
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

                var user = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == reservation.UserId);

                NotFoundException.ThrowIfNull(user);

                var notification = new NotificationCreateDto
                {
                    UserId = user.Id,
                    AccommodationUnitId = accommodationUnitId,
                    Title = "Otkazana rezervacija",
                    Description = $"Vaša rezervacija nad objektom {reservation.AccommodationUnit.Title} je otkazana zbog neaktivnosti objekta.",
                    Type = NotificationType.System
                };

                await _notificationService.SendAsync(notification, CancellationToken.None);

                if (user!.UserSettings!.ReceiveEmails)
                {
                    var mail = new MailCreateDto
                    {
                        Subject = $"Otkazana rezervacija",
                        Content = $"Vaša rezervacija nad objektom {reservation.AccommodationUnit.Title} je otkazana zbog neaktivnosti objekta.",
                        Recipient = user.Email,
                        Sender = _mailConfig.Username
                    };

                    _rabbitMQProducer.SendMessage(mail);
                }
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
                    && x.UserSettings!.ReceiveNotifications
                    && usersSubscribed.Contains(x.Id)).ToListAsync();


            foreach (var item in users)
            {
                var notification = new NotificationCreateDto
                {
                    UserId = item.Id,
                    Title = "Promjena aktivnosti objekta",
                    AccommodationUnitId = accommodationUnitId,
                    Description = accommodationUnit.Status == AccommodationUnitStatus.Active ?
                    $"Objekat {accommodationUnit.Title} je ponovo dostupan za rezervacije" : $"Objekat {accommodationUnit.Title} je, od danas, neaktivan za rezervacije!",
                    Type = NotificationType.AccommodationUnit,
                };

                await _notificationService.SendAsync(notification, CancellationToken.None);

                if (item!.UserSettings!.ReceiveEmails)
                {
                    var mail = new MailCreateDto
                    {
                        Subject = "Promjena aktivnosti objekta",
                        Content = accommodationUnit.Status == AccommodationUnitStatus.Active ?
                        $"Objekat {accommodationUnit.Title} je ponovo dostupan za rezervacije" : $"Objekat {accommodationUnit.Title} je, od danas, neaktivan za rezervacije!",
                        Recipient = item.Email,
                        Sender = _mailConfig.Username
                    };

                    _rabbitMQProducer.SendMessage(mail);
                }
            }
        }

        public async Task NotifyUsersAboutAccommodationUnitUpdate(long accommodationUnitId)
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
                    Title = $"{accommodationUnit.Title} - Nove promjene",
                    AccommodationUnitId = accommodationUnitId,
                    Description = "Objekat koji ste označili kao Omiljeni je upravo promijenio svoje uslove",
                    Type = NotificationType.AccommodationUnit,
                };

                await _notificationService.SendAsync(notification, CancellationToken.None);
            }
        }

        public async Task NotifyUserAboutNewReview(long userId)
        {
            var user = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == userId);

            NotFoundException.ThrowIfNull(user);

            var notification = new NotificationCreateDto
            {
                UserId = user.Id,
                Title = "Upravo ste ocijenjeni kao gost",
                Description = "Vlasnik objekta nad kojim ste prethodno imali rezervaciju Vam je ostavio recenziju",
                Type = NotificationType.AccommodationUnit
            };

            await _notificationService.SendAsync(notification, CancellationToken.None);

            if (user!.UserSettings!.ReceiveEmails)
            {
                var mail = new MailCreateDto
                {
                    Subject = "Upravo ste ocijenjeni kao gost",
                    Content = "Vlasnik objekta nad kojim ste prethodno imali rezervaciju Vam je ostavio recenziju",
                    Recipient = user.Email,
                    Sender = _mailConfig.Username
                };

                _rabbitMQProducer.SendMessage(mail);
            }
        }
    }
}
