using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IUserService
    {
        Task<UserGetDto> CreateUserAsync(UserCreateDto request, CancellationToken cancellationToken);
        Task<UserGetDto> UpdateUserAsync(long id, UserUpdateDto request, CancellationToken cancellationToken);  
        Task<UserGetDto> GetUserByIdAsync(long id, CancellationToken cancellationToken);
        Task<GetReviewsResponse> GetUserReviewsAsync(long id, CancellationToken cancellationToken);
        Task<UserGetDto> ChangePasswordAsync(long id, ChangePasswordDto request, CancellationToken cancellationToken);
        Task<UserSettingsGetDto> UpdateSettingsAsync(long id, UpdateSettingsDto request, CancellationToken cancellationToken);
        Task<ReviewGetDto> CreateReviewAsync(long id, ReviewCreateDto request, CancellationToken cancellationToken);
    }
}
