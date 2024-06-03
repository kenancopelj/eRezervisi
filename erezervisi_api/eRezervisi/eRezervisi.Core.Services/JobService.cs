﻿using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Core.Services
{
    public class JobService : IJobService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly INotifyService _notifyService;

        public JobService(eRezervisiDbContext dbContext, INotifyService notifyService)
        {
            _dbContext = dbContext;
            _notifyService = notifyService;
        }

        public async Task CheckAccommodationUnitsAsync(CancellationToken cancellationToken)
        {
            var now = DateOnly.FromDateTime(DateTime.UtcNow);

            var accommodationUnits = await _dbContext.AccommodationUnits
                .Where(x => x.Status == AccommodationUnitStatus.Active && x.DeactivateAt <= now)
                .ToListAsync(cancellationToken);

            foreach (var item in accommodationUnits)
            {
                item.Deactivate(now);
            }

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task CheckReservationsAsync(CancellationToken cancellationToken)
        {
            var now = DateTime.UtcNow;

            var reservations = await _dbContext.Reservations.Where(x => x.From >= now && x.Status == ReservationStatus.Confirmed).ToListAsync(cancellationToken);

            foreach (var item in reservations)
            {
                item.ChangeStatus(ReservationStatus.InProgress);
            }

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task CheckUsersAsync(CancellationToken cancellationToken)
        {
            var now = DateTime.UtcNow;

            var users = await _dbContext.Users.Include(x => x.UserCredentials)
                .Where(x => x.IsActive && x.UserCredentials!.RefreshTokenExpiresAtUtc.HasValue
                && x.UserCredentials!.RefreshTokenExpiresAtUtc.Value.AddDays(90) < now)
                .ToListAsync(cancellationToken);

            foreach (var user in users)
            {
                user.IsActive = false;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task CompleteReservationsAsync(CancellationToken cancellationToken)
        {
            var now = DateTime.UtcNow;

            var reservations = await _dbContext.Reservations.Where(x => x.To <= now && x.Status == ReservationStatus.InProgress).ToListAsync(cancellationToken);

            foreach (var item in reservations)
            {
                item.ChangeStatus(ReservationStatus.Completed);
            }

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task RemindAboutPasswordChange(CancellationToken cancellationToken)
        {
            var now = DateTime.UtcNow;

            var users = await _dbContext.Users.Include(x => x.UserCredentials)
                .Where(x => x.IsActive && x.UserCredentials!.LastPasswordChangeAt.AddDays(30) < now)
                .ToListAsync(cancellationToken);

            foreach (var user in users)
            {
                await _notifyService.NotifyUserAboutPasswordChange(user.Id);
            }
        }
    }
}