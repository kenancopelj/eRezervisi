using eRezervisi.Common.Dtos.Statistics;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Common.Shared.Requests.Statistics;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Core.Services
{
    public class StatisticsService : IStatisticsService
    {

        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;

        public StatisticsService(eRezervisiDbContext dbContext, IJwtTokenReader jwtTokenReader)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
        }

        public async Task<List<GetReservationsByYearDto>> GetReservationByYearAsync(GetReservationsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var allMonths = Enumerable.Range(1, 12).ToList();

            var reservationsByMonth = await _dbContext.Reservations
                .Where(x => x.AccommodationUnit.OwnerId == userId &&
                            x.From.Year == request.Year)
                .GroupBy(x => x.From.Month)
                .Select(g => new
                {
                    Month = g.Key,
                    TotalReservations = g.Count()
                })
                .ToListAsync(cancellationToken);

            var result = allMonths
                .GroupJoin(
                    reservationsByMonth,
                    month => month,
                    reservation => reservation.Month,
                    (month, reservationGroup) => new GetReservationsByYearDto
                    {
                        Month = month,
                        TotalReservations = reservationGroup.FirstOrDefault()?.TotalReservations ?? 0
                    })
                .ToList();

            return result;
        }


        public Task<List<GetReservationsByYearDto>> GetReservationByMonthAsync(GetReservationsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public async Task<List<GetGuestsByYearDto>> GetGuestsByYearAsync(GetGuestsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var allMonths = Enumerable.Range(1, 12).ToList();

            var reservationsByMonth = await _dbContext.Reservations
                .Where(x => x.AccommodationUnit.OwnerId == userId &&
                            x.From.Year == request.Year)
                .GroupBy(x => x.From.Month)
                .Select(g => new
                {
                    Month = g.Key,
                    TotalGuests = g.Sum(x => x.NumberOfAdults + x.NumberOfChildren)
                })
                .ToListAsync(cancellationToken);

            var result = allMonths
                .GroupJoin(
                    reservationsByMonth,
                    month => month,
                    reservation => reservation.Month,
                    (month, reservationGroup) => new GetGuestsByYearDto
                    {
                        Month = month,
                        TotalGuests = reservationGroup.FirstOrDefault()?.TotalGuests ?? 0
                    })
                .ToList();

            return result;
        }

        public Task<GetReservationsByYearDto> GetMostPopularAccommodationUnits(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<List<GetGuestsByYearDto>> GetGuestsByMonthAsync(GetGuestsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
