using eRezervisi.Common.Dtos.Dashboard;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Shared.Requests.Dashboard;
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

        public async Task<DashboardDataResponse> GetDashboardDataAsync(GetDashboardDataRequest request, CancellationToken cancellationToken)
        {
            try
            {


                var loggedUserId = _jwtTokenReader.GetUserIdFromToken();

                var expectedArrivals = await _dbContext.Reservations
                    .Where(x => x.AccommodationUnit.OwnerId == loggedUserId &&
                                x.Status == ReservationStatus.Confirmed &&
                                x.From.Year == request.Year &&
                                x.From.Month == request.Month)
                    .CountAsync(cancellationToken);

                var availableAccommodationUnits = await _dbContext.AccommodationUnits
                    .Where(x => x.OwnerId == loggedUserId &&
                                x.Status == AccommodationUnitStatus.Active)
                    .CountAsync(cancellationToken);

                var numberOfGuests = await _dbContext.Reservations
                    .Where(x => x.AccommodationUnit.OwnerId == loggedUserId &&
                                x.Status == ReservationStatus.Confirmed &&
                                x.From.Year == request.Year &&
                                x.From.Month == request.Month)
                    .SumAsync(x => x.NumberOfAdults + x.NumberOfChildren, cancellationToken);

                var numberOfReviews = await _dbContext.AccommodationUnitReviews
                    .Where(x => x.AccommodationUnit.OwnerId == loggedUserId)
                    .CountAsync(cancellationToken);

                var latestReviews = await _dbContext.AccommodationUnitReviews
                    .Include(x => x.Review)
                    .Where(x => x.AccommodationUnit.OwnerId == loggedUserId)
                    .OrderByDescending(x => x.Review.CreatedAt)
                    .Take(5)
                    .Select(x => new ReviewGetDto
                    {
                        Id = x.ReviewId,
                        Title = x.Review.Title,
                        Note = x.Review.Note,
                        Rating = x.Review.Rating,
                        Reviewer = _dbContext.Users.First(u => u.Id == x.Review.CreatedBy).GetFullName(),
                        ReviewerId = x.Review.CreatedBy,
                    })
                    .ToListAsync(cancellationToken);

                var latestReservations = await _dbContext.Reservations
                    .Include(x => x.AccommodationUnit)
                    .Where(x => x.AccommodationUnit.OwnerId == loggedUserId)
                    .OrderByDescending(x => x.CreatedAt)
                    .Take(5)
                    .Select(x => new ReservationGetShortDto
                    {
                        Id = x.Id,
                        Guest = _dbContext.Users.First(u => u.Id == x.CreatedBy).GetFullName(),
                        From = x.From,
                        To = x.To,
                        TotalPrice = x.TotalPrice,
                        AccommodationUnit = x.AccommodationUnit.Title
                    })
                    .ToListAsync(cancellationToken);

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
            catch (Exception ex)
            {
                var o = ex;
                throw;
            }
        }
    }
}
