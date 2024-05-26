using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IUserService
    {
        Task<UserGetDto> CreateUserAsync(UserCreateDto request, CancellationToken cancellationToken);
        Task<UserGetDto> UpdateUserAsync(long id, UserUpdateDto request, CancellationToken cancellationToken);  
        Task<UserGetDto> GetUserByIdAsync(long id, CancellationToken cancellationToken);
        Task<GetGuestsResponse> GetGuestsAsync(CancellationToken cancellationToken);
        Task<GetReviewsResponse> GetUserReviewsAsync(long id, CancellationToken cancellationToken);
        Task<UserGetDto> ChangePasswordAsync(long id, ChangePasswordDto request, CancellationToken cancellationToken);
        Task<UserSettingsGetDto> UpdateSettingsAsync(long id, UpdateSettingsDto request, CancellationToken cancellationToken);
    }
}
