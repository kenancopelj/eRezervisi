using eRezervisi.Common.Dtos.Guest;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Guest;
using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IGuestService
    {
        Task<PagedResponse<GuestGetDto>> GetGuestsPagedAsync(GetGuestsRequest request, CancellationToken cancellationToken);
        Task CreateGuestReviewAsync(long guestId, ReviewCreateDto request, CancellationToken cancellationToken);
        Task<GuestReview?> GetReviewByOwnerId(long userId, CancellationToken cancellationToken);
    }
}
