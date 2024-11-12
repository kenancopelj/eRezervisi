using AutoMapper;
using eRezervisi.Common.Dtos.Guest;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Guest;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace eRezervisi.Core.Services
{
    public class GuestService : IGuestService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IMapper _mapper;

        public GuestService(eRezervisiDbContext dbContext,
            IJwtTokenReader jwtTokenReader,
            IMapper mapper)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
            _mapper = mapper;
        }

        public async Task CreateGuestReviewAsync(long guestId, ReviewCreateDto request, CancellationToken cancellationToken)
        {
            var guest = await _dbContext.Users.FirstOrDefaultAsync(x => x.Id == guestId, cancellationToken);

            NotFoundException.ThrowIfNull(guest);

            var review = _mapper.Map<Review>(request);

            await _dbContext.Reviews.AddAsync(review, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            var guestReview = new GuestReview
            {
                ReviewId = review.Id,
                GuestId = guestId
            };

            await _dbContext.GuestReviews.AddAsync(guestReview, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task<GuestReview?> GetReviewByOwnerId(long guestId, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var review = await _dbContext.GuestReviews.Include(x => x.Review).FirstOrDefaultAsync(x => x.Review.CreatedBy == userId && x.GuestId == guestId);

            return review;
        }

        public async Task<PagedResponse<GuestGetDto>> GetGuestsPagedAsync(GetGuestsRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.Reservations.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Reservation>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var guests = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Reservation, bool>> filterExpression)>()
                {
                    (true, x => x.Status == ReservationStatus.InProgress || x.Status == ReservationStatus.Completed),
                    (true, x => x.AccommodationUnit.OwnerId == userId),
                    (!string.IsNullOrEmpty(searchTerm), x => x.User.GetFullName().ToLower().Contains(searchTerm))
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new GuestGetDto
                {
                    Id = x.UserId,
                    FullName = x.User.GetFullName(),
                    Phone = x.User.Phone,
                    Email = x.User.Email,
                    AccommodationUnitTitle = x.AccommodationUnit.Title,
                }, cancellationToken);

            return guests;
        }

        public async Task<bool> IsUserAllowedToMakeReviewAsync(long accommodationUnitId, CancellationToken cancellationToken)
        {
            var loggedUserId = _jwtTokenReader.GetUserIdFromToken();

            var isAllowed = await _dbContext.Reservations
                .AnyAsync(x => x.AccommodationUnitId == accommodationUnitId &&
                          x.UserId == loggedUserId && x.Status == ReservationStatus.Completed, cancellationToken);

            return isAllowed;
        } 

        private Expression<Func<Reservation, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "title":
                    return x => x.User.GetFullName();
                default:
                    return x => x.Id;
            }
        }
    }
}
