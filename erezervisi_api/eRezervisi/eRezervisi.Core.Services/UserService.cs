using AutoMapper;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.Role;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
using eRezervisi.Common.Shared;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Hangfire;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Core.Services
{
    public class UserService : IUserService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IHashService _hashService;
        private readonly IBackgroundJobClient _backgroundJobClient;
        private readonly IMapper _mapper;
        public UserService(eRezervisiDbContext dbContext,
            IHashService hashService,
            IMapper mapper,
            IBackgroundJobClient backgroundJobClient)
        {
            _dbContext = dbContext;
            _hashService = hashService;
            _mapper = mapper;
            _backgroundJobClient = backgroundJobClient;
        }

        public async Task<UserGetDto> CreateUserAsync(UserCreateDto request, CancellationToken cancellationToken)
        {
            if (await _dbContext.Users.AnyAsync(x => x.UserCredentials!.Username == request.Username, cancellationToken))
            {
                DuplicateException.ThrowIf(true, "Navedeno korisničko ime je u upotrebi!");
            }

            var passwordSalt = Guid.NewGuid().ToString("N");

            var passwordHash = _hashService.GenerateHash(request.Password, passwordSalt);

            var user = _mapper.Map<User>(request);

            user.RoleId = Roles.MobileUser.Id;

            user.IsActive = true;

            user.UserCredentials = new UserCredentials
            {
                PasswordHash = passwordHash,
                PasswordSalt = passwordSalt,
                Username = request.Username,
                RefreshToken = null,
                RefreshTokenExpiresAtUtc = null
            };

            await _dbContext.Users.AddAsync(user, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<UserGetDto>(user);
        }

        public Task<GetGuestsResponse> GetGuestsAsync(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<UserGetDto> GetUserByIdAsync(long id, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public async Task<UserGetDto> ChangePasswordAsync(long id, ChangePasswordDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            if (!user.IsActive)
            {
                throw new DomainException("InactiveUser", "Korisnički nalog nije aktivan!");
            }

            if (request.NewPassword != null)
            {
                var passwordSalt = Guid.NewGuid().ToString("N");

                var passwordHash = _hashService.GenerateHash(request.NewPassword, passwordSalt);

                user.UserCredentials ??= new UserCredentials
                {
                    UserId = id,
                    PasswordHash = passwordHash,
                    PasswordSalt = passwordSalt,
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null
                };
            }
            else
            {
                _backgroundJobClient.Enqueue<IUserCredentialService>(x => x.GenerateCredentialAndSendEmailAsync(id, request.Username, user.Email));
            }

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<UserGetDto>(user);
        }

        public async Task<GetReviewsResponse> GetUserReviewsAsync(long id, CancellationToken cancellationToken)
        {
            var reviews = await _dbContext.GuestReviews
                .Include(x => x.Guest)
                .Include(x => x.Review)
                .Where(x => x.GuestId == id)
                .Select(x => new ReviewGetDto
                {
                    Id = x.ReviewId,
                    Reviewer = x.Guest.GetFullName(),
                    Note = x.Review.Note,
                    Title = x.Review.Title,
                    Rating = x.Review.Rating,
                })
                .ToListAsync(cancellationToken);

            return new GetReviewsResponse
            {
                Reviews = reviews
            };
        }

        public async Task<UserGetDto> UpdateUserAsync(long id, UserUpdateDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            _mapper.Map(request, user);

            if (await _dbContext.Users.AnyAsync(x => x.Id != id && x.UserCredentials!.Username == request.Username))
            {
                DuplicateException.ThrowIf(true, "Navedeno korisničko ime je već u upotrebi.");
            }

            if (user.UserCredentials != null)
            {
                user.UserCredentials.Username = request.Username;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            var response = _mapper.Map<UserGetDto>(user);

            response.Username = user.UserCredentials!.Username;

            response.Role = _mapper.Map<RoleGetDto>(user.Role);

            response.UserSettings = _mapper.Map<UserSettingsGetDto>(user.UserSettings);

            return response;
        }

        public async Task<UserSettingsGetDto> UpdateSettingsAsync(long id, UpdateSettingsDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Set<User>().FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            user.UserSettings ??= _mapper.Map<UserSettings>(request);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<UserSettingsGetDto>(user.UserSettings);
        }
    }
}
