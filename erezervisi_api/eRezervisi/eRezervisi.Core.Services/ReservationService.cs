using AutoMapper;
using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.Canton;
using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Hangfire;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class ReservationService : IReservationService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IMapper _mapper;
        private readonly IBackgroundJobClient _backgroundJobClient;

        public ReservationService(eRezervisiDbContext dbContext,
            IJwtTokenReader jwtTokenReader,
            IMapper mapper,
            IBackgroundJobClient backgroundJobClient)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
            _mapper = mapper;
            _backgroundJobClient = backgroundJobClient;
        }

        public async Task<ReservationGetDto> CreateReservationAsync(ReservationCreateDto request, CancellationToken cancellationToken)
        {
            var accommodationUnit = await _dbContext.AccommodationUnits.Include(x => x.Owner).ThenInclude(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == request.AccommodationUnitId);

            NotFoundException.ThrowIfNull(accommodationUnit);

            if (accommodationUnit.DeactivateAt != null && DateOnly.FromDateTime(request.To) <= accommodationUnit.DeactivateAt)
            {
                throw new DomainException("AccommodationUnitInactive", $"Odabrani objekat je neaktivan od {accommodationUnit.DeactivateAt}.");
            }

            if (accommodationUnit.Status != AccommodationUnitStatus.Active)
            {
                throw new DomainException("AccommodationUnitInactive", "Odabrani objekat trenutno nije dostupan za rezervacije.");
            }

            var alreadyReserved = await _dbContext.Reservations.AnyAsync(x => x.AccommodationUnitId == request.AccommodationUnitId &&
                                                                              x.From >= request.From && x.To <= request.To);

            DuplicateException.ThrowIf(alreadyReserved, "Rezervacija za odabrani period već postoji!");

            var policy = accommodationUnit.AccommodationUnitPolicy;

            if (request.TotalPeople > policy.Capacity)
            {
                throw new DomainException("MaximumCapacity", "Broj osoba na rezervaciji je veći od kapaciteta objekta");
            }

            var userId = _jwtTokenReader.GetUserIdFromToken();

            var reservation = _mapper.Map<Reservation>(request);

            reservation.Code = await GenerateCode(accommodationUnit, cancellationToken);

            reservation.UserId = userId;

            reservation.CalculateTotalPrice(accommodationUnit.Price);

            await _dbContext.AddAsync(reservation, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            if (accommodationUnit.Owner.UserSettings!.ReceiveEmails)
            {
                // Notify owner about new reservation via email if enabled in user settings
                NotifyOwner(reservation.Id);
            }

            return _mapper.Map<ReservationGetDto>(reservation);
        }

        public async Task CancelReservationAsync(long id, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.Include(x => x.AccommodationUnit).ThenInclude(x => x.Owner).ThenInclude(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            if (reservation.Status == ReservationStatus.Cancelled)
            {
                throw new DomainException("ReservationCancelled", "Rezervacija je već otkazana!");
            }

            reservation.ChangeStatus(ReservationStatus.Cancelled);

            await _dbContext.SaveChangesAsync(cancellationToken);

            if (reservation.AccommodationUnit.Owner.UserSettings!.ReceiveEmails)
            {
                NotifyOwner(reservation.Id);
            }
        }

        public async Task ConfirmReservationAsync(long id, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.Include(x => x.AccommodationUnit).ThenInclude(x => x.Owner).ThenInclude(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            if (reservation.AccommodationUnit.Status != AccommodationUnitStatus.Active)
            {
                throw new DomainException("UnitNotActive", "Objekat trenutno nije aktivan");
            }

            if (reservation.Status != ReservationStatus.Draft)
            {
                throw new DomainException("NotAllowed", "Nije moguće potvrditi odabranu rezervaciju!");
            }

            reservation.ChangeStatus(ReservationStatus.Confirmed);

            await _dbContext.SaveChangesAsync(cancellationToken);

            if (reservation.AccommodationUnit.Owner.UserSettings!.ReceiveEmails)
            {
                NotifyOwner(reservation.Id);
            }
        }

        public async Task DeleteReservationAsync(long id, CancellationToken cancellationToken)
        {
            var reservation = await _dbContext.Reservations.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(reservation);

            reservation.Deleted = true;
            reservation.DeletedAt = DateTime.Now;
            reservation.DeletedBy = _jwtTokenReader.GetUserIdFromToken();

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task<PagedResponse<ReservationGetDto>> GetReservationPagedAsync(GetReservationsRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.Reservations.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Reservation>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var reservations = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Reservation, bool>> FilterExpression)>()
                {
                    (true, x => x.AccommodationUnit.OwnerId == userId)
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new ReservationGetDto
                {
                    Id = x.Id,
                    Code = x.Code,
                    GuestId = x.UserId,
                    Guest = x.User.GetFullName(),
                    AccommodationUnitId = x.AccommodationUnitId,
                    AccommodationUnit = _mapper.Map<AccommodationUnitGetDto>(x.AccommodationUnit),
                    From = x.From,
                    To = x.To,
                    PaymentMethod = x.PaymentMethod,
                    NumberOfAdults = x.NumberOfAdults,
                    NumberOfChildren = x.NumberOfChildren,
                    TotalPeople = x.TotalPeople,
                    TotalDays = x.TotalDays,
                    CreatedAt = x.CreatedAt,
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

        public async Task<ReservationByStatusesResponse> GetUserReservationsAsync(GetReservationsByStatusRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var reservations = await _dbContext.Reservations
               .AsNoTracking()
               .Where(x => x.UserId == userId && x.Status == request.Status)
               .Select(x => new ReservationByStatusDto
               {
                   Id = x.Id,
                   Code = x.Code,
                   AccommodationUnit = x.AccommodationUnit.Title,
                   From = x.From,
                   To = x.To,
                   TotalPeople = x.TotalPeople,
                   TotalDays = x.TotalDays,
                   CreatedAt = x.CreatedAt,
                   TotalPrice = x.TotalPrice
               })
               .ToListAsync(cancellationToken);

            return new ReservationByStatusesResponse
            {
                Reservations = reservations
            };
        }

        private void NotifyOwner(long reservationId)
        {
            _backgroundJobClient.Enqueue<INotifyService>(x => x.NotifyOwnerAboutReservationStatus(reservationId));
        }

        private async Task<string> GenerateCode(AccommodationUnit accommodationUnit, CancellationToken cancellationToken)
        {
            var currentYear = DateTime.Now.Year;

            var lastNumber = await _dbContext.Reservations.Where(x => x.AccommodationUnitId == accommodationUnit.Id &&
                                                                      x.CreatedAt.Year == currentYear)
                                                          .CountAsync(cancellationToken);

            return $"{accommodationUnit.Title.Trim()}-{lastNumber + 1}/{currentYear}";
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
