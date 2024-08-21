using eRezervisi.Common.Dtos.Reservation;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Reservation;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IReservationService
    {
        Task<PagedResponse<ReservationGetDto>> GetReservationPagedAsync(GetReservationsRequest request, CancellationToken cancellationToken);
        Task<ReservationGetDto> CreateReservationAsync(ReservationCreateDto request, CancellationToken cancellationToken);
        Task<ReservationGetDto> UpdateReservationAsync(long id, ReservationUpdateDto request, CancellationToken cancellationToken);
        Task DeleteReservationAsync(long id, CancellationToken cancellationToken);
        Task ConfirmReservationAsync(long id, CancellationToken cancellationToken);
        Task CancelReservationAsync(long id, CancellationToken cancellationToken);
        Task<ReservationByStatusesResponse> GetUserReservationsAsync(GetReservationsByStatusRequest request, CancellationToken cancellationToken);
    }
}
