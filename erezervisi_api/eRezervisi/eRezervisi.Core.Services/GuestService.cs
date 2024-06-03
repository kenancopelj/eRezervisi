using AutoMapper;
using eRezervisi.Common.Dtos.Guest;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Guest;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;
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

        public async Task<PagedResponse<GuestGetDto>> GetGuestsPagedAsync(GetGuestsRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.Reservations.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Reservation>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var guests = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Reservation, bool>> filterExpression)>()
                {
                    (!string.IsNullOrEmpty(searchTerm), x => x.User.GetFullName().ToLower().Contains(searchTerm))
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new GuestGetDto
                {
                    Id = x.UserId,
                    FullName = x.User.GetFullName(),
                }, cancellationToken);

            return guests;
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
