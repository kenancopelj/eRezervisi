using eRezervisi.Common.Dtos.Dashboard;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Core.Services
{
    public class DashboardService : IDashboardService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;

        public DashboardService(eRezervisiDbContext dbContext, IJwtTokenReader jwtTokenReader)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
        }

        public async Task<DashboardDataResponse> GetDashboardDataAsync(CancellationToken cancellationToken)
        {
            var loggedUserId = _jwtTokenReader.GetUserIdFromToken();

            var currentYear = DateTime.Now.Year;
            var currentMonth = DateTime.Now.Month;
            var currentDate = DateTime.Now.Date;

            var from = new DateTime(currentYear, currentMonth, 1);
            var to = from.AddMonths(1).AddDays(-1);

            var anyReviews = await _dbContext.AccommodationUnitReviews
                .Include(x => x.AccommodationUnit)
                .AnyAsync(x => x.AccommodationUnit.OwnerId == loggedUserId);

            var anyReservations = await _dbContext.Reservations
                .Include(x => x.AccommodationUnit)
                .AnyAsync(x => x.AccommodationUnit.OwnerId == loggedUserId);


            var expectedArrivals = await _dbContext.Reservations
                .CountAsync(x => x.AccommodationUnit.OwnerId == loggedUserId && 
                    x.From < to && x.To > from &&
                    x.Status == ReservationStatus.Confirmed
                    ,cancellationToken);

            var availableAccommodationUnits = await _dbContext.AccommodationUnits
                .CountAsync(x => x.OwnerId == loggedUserId &&
                            x.Status == AccommodationUnitStatus.Active, cancellationToken);

            var numberOfGuests = await _dbContext.Reservations
                .Where(x => x.AccommodationUnit.OwnerId == loggedUserId &&
                    x.From < to && x.To > from &&
                    x.Status == ReservationStatus.InProgress)
                .SumAsync(x => x.NumberOfAdults + x.NumberOfChildren, cancellationToken);

            var numberOfReviews = await _dbContext.AccommodationUnitReviews
                .Include(x => x.AccommodationUnit)
                .CountAsync(x => x.AccommodationUnit.OwnerId == loggedUserId &&
                            x.AccommodationUnit.Status == AccommodationUnitStatus.Active, cancellationToken);

            var latestReviews = anyReviews ? await _dbContext.AccommodationUnitReviews
                .Include(x => x.Review)
                .Where(x => x.AccommodationUnit.OwnerId == loggedUserId)
                .OrderByDescending(x => x.Review.CreatedAt)
                .Take(2)
                .Select(x => new ReviewGetDto
                {
                    Id = x.ReviewId,
                    ReviewerId = x.Review.CreatedBy,
                    Note = x.Review.Note,
                    Rating = x.Review.Rating,
                    Reviewer = _dbContext.Users.First(u => u.Id == x.Review.CreatedBy).GetFullName(),
                    ReviewerImage = _dbContext.Users.FirstOrDefault(u => u.Id == x.Review.CreatedBy) != null ? _dbContext.Users.First(u => u.Id == x.Review.CreatedBy).Image : null,
                    MinutesAgo = Math.Floor((DateTime.UtcNow - x.Review.CreatedAt).TotalMinutes),
                    HoursAgo = Math.Floor((DateTime.UtcNow - x.Review.CreatedAt).TotalHours),
                    DaysAgo = Math.Floor((DateTime.UtcNow - x.Review.CreatedAt).TotalDays)
                })
                .ToListAsync(cancellationToken) : [];

            var latestReservations = anyReservations ? await _dbContext.Reservations
                .Include(x => x.AccommodationUnit)
                .Where(x => x.AccommodationUnit.OwnerId == loggedUserId)
                .OrderByDescending(x => x.CreatedAt)
                .Take(5)
                .Select(x => new ReservationGetShortDto
                {
                    Id = x.Id,
                    Guest = x.User.GetFullName(),
                    From = x.From,
                    To = x.To,
                    TotalPrice = x.TotalPrice,
                    AccommodationUnit = x.AccommodationUnit.Title,
                    GuestImage = x.User.Image
                })
                .ToListAsync(cancellationToken) : [];

            return new DashboardDataResponse
            {
                AvailableAccommodationUnits = availableAccommodationUnits,
                ExpectedArrivals = expectedArrivals,
                LatestReservations = latestReservations,
                LatestReviews = latestReviews,
                NumberOfGuests = numberOfGuests,
                NumberOfReviews = numberOfReviews,
            };
        }
    }
}
