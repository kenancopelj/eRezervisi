using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.User;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IUserService
    {
        Task<UserGetDto> CreateUserAsync(UserCreateDto request, CancellationToken cancellationToken);
        Task<UserGetDto> UpdateUserAsync(long id, UserUpdateDto request, CancellationToken cancellationToken);  
        Task<UserGetDto> GetUserByIdAsync(long id, CancellationToken cancellationToken);
        Task<PagedResponse<ReviewGetDto>> GetUsersReviewsPagedAsync(GetUserReviewsRequest request, CancellationToken cancellationToken);
        Task ChangePasswordAsync(long id, ChangePasswordDto request, CancellationToken cancellationToken);
        Task<UserSettingsGetDto> UpdateSettingsAsync(long id, UpdateSettingsDto request, CancellationToken cancellationToken);
        Task<ReviewGetDto> CreateReviewAsync(long id, ReviewCreateDto request, CancellationToken cancellationToken);
        Task RequestForgottenPasswordCodeAsync(RequestResetPasswordCodeDto request, CancellationToken cancellationToken);
        Task CheckForgottenPasswordCodeAsync(CheckForgottenPasswordCodeDto request, CancellationToken cancellationToken);
        Task ResetPasswordAsync(ResetPasswordDto request, CancellationToken cancellationToken);
        Task<bool> CheckUsernameAsync(CheckUsernameDto request, CancellationToken cancellationToken);
        Task<bool> CheckEmailAsync(CheckEmailDto request, CancellationToken cancellationToken);
        Task<bool> CheckPhoneNumberAsync(CheckPhoneNumberDto request, CancellationToken cancellationToken);
    }
}
