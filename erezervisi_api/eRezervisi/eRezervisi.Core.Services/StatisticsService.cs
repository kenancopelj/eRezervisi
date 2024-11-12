using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Statistics;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Common.Shared.Requests.Statistics;
using eRezervisi.Core.Domain.Entities;
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
                            x.From.Year == request.Year &&
                            (!request.Month.HasValue || x.From.Month == request.Month))
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

        public async Task<List<GetGuestsByYearDto>> GetGuestsByYearAsync(GetGuestsByYearOrMonthRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var allMonths = Enumerable.Range(1, 12).ToList();

            var reservationsByMonth = await _dbContext.Reservations
                .Where(x => x.AccommodationUnit.OwnerId == userId &&
                            x.From.Year == request.Year &&
                            (!request.Month.HasValue || x.From.Month == request.Month))
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

    }
}