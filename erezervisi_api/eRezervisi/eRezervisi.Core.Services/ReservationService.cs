using AutoMapper;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class ReservationService : IReservationService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IMapper _mapper;

        public ReservationService(eRezervisiDbContext dbContext,
            IJwtTokenReader jwtTokenReader,
            IMapper mapper)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
            _mapper = mapper;
        }
        public async Task<ReservationGetDto> CreateReservationAsync(ReservationCreateDto request, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.FirstOrDefaultAsync(x => x.Id == request.AccommodationUnitId);

            NotFoundException.ThrowIfNull(accommodationUnit);

            if (accommodationUnit.Status == Domain.Enums.AccommodationUnitStatus.Inactive)
            {
                throw new DomainException("AccommodationUnitInactive", "Odabrani objekat trenutno nije dostupan za rezervacije.");
            }

            var alreadyReserved = await _dbContext.Reservations.AnyAsync(x => x.AccommodationUnitId == request.AccommodationUnitId &&
                                                                              x.From > request.From && x.To < request.To);

            DuplicateException.ThrowIf(alreadyReserved, "Rezervacija za odabrani period već postoji!");

            var policy = accommodationUnit.AccommodationUnitPolicy;

            if (policy.Capacity > request.TotalPeople)
            {
                throw new DomainException("MaximumCapacity", "Broj osoba na rezervaciji je veći od kapaciteta objekta");
            }

            var userId = _jwtTokenReader.GetUserIdFromToken();

            var reservation = _mapper.Map<Reservation>(request);

            reservation.UserId = userId;

            reservation.CalculateTotalPrice();

            await _dbContext.AddAsync(reservation, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<ReservationGetDto>(reservation);
        }

        public async Task CancelReservationAsync(long id, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            if (reservation.Status == ReservationStatus.Cancelled)
            {
                throw new DomainException("ReservationCancelled", "Rezervacija je već otkazana!");
            }

            reservation.ChangeStatus(ReservationStatus.Cancelled);

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task ConfirmReservationAsync(long id, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            if (reservation.Status == ReservationStatus.Confirmed)
            {
                reservation.ChangeStatus(ReservationStatus.Confirmed);
            }

            await _dbContext.SaveChangesAsync(cancellationToken);
        }


        public async Task DeleteReservationAsync(long id, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            reservation.Deleted = true;
            reservation.DeletedAt = DateTime.UtcNow;
            reservation.DeletedBy = _jwtTokenReader.GetUserIdFromToken();

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task<PagedResponse<ReservationGetDto>> GetReservationPagedAsync(GetReservationsRequest request, CancellationToken cancellationToken)
        {
            var queryable = _dbContext.Reservations.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Reservation>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var reservations = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Reservation, bool>> FilterExpression)>(),
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new ReservationGetDto
                {
                    Id = x.Id,
                    Code = x.Code,
                    GuestId = x.UserId,
                    Guest = x.User.GetFullName(),
                    AccommodationUnitId = x.AccommodationUnitId,
                    AccommodationUnit = x.AccommodationUnit.Title,
                    From = x.From,
                    To = x.To,
                    PaymentMethod = x.PaymentMethod,
                    NumberOfAdults = x.NumberOfAdults,
                    NumberOfChildren = x.NumberOfChildren,
                    TotalPeople = x.TotalPeople,
                    TotalDays = x.TotalDays,
                    CreatedAt = DateOnly.FromDateTime(x.CreatedAt),
                    TotalPrice = x.TotalPrice
                }, cancellationToken);

            return reservations;
        }

        public async Task<ReservationGetDto> UpdateReservationAsync(long id, ReservationUpdateDto request, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            _mapper.Map(request, reservation);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<ReservationGetDto>(reservation);
        }

        private Expression<Func<Reservation, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.Id;
                default:
                    return x => x.Id;
            }
        }
    }
}
