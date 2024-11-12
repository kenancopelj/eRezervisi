using AutoMapper;
using eRezervisi.Common.Dtos.Mail;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.Role;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Domain.Exceptions;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Hangfire;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.Linq.Expressions;
using System.Security.Cryptography;
using eRezervisi.Common.Shared.Requests.User;

namespace eRezervisi.Core.Services
{
    public class UserService : IUserService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IHashService _hashService;
        private readonly IBackgroundJobClient _backgroundJobClient;
        private readonly IMapper _mapper;
        private readonly IStorageService _storageService;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IRabbitMQProducer _rabbitMQProducer;
        private readonly MailConfig _mailConfig;
        private readonly ICacheService _cacheService;

        public UserService(eRezervisiDbContext dbContext,
            IHashService hashService,
            IMapper mapper,
            IBackgroundJobClient backgroundJobClient,
            IStorageService storageService,
            IJwtTokenReader jwtTokenReader,
            IRabbitMQProducer rabbitMQProducer,
            IOptionsSnapshot<MailConfig> mailConfig,
            ICacheService cacheService)
        {
            _dbContext = dbContext;
            _hashService = hashService;
            _mapper = mapper;
            _backgroundJobClient = backgroundJobClient;
            _storageService = storageService;
            _jwtTokenReader = jwtTokenReader;
            _rabbitMQProducer = rabbitMQProducer;
            _mailConfig = mailConfig.Value;
            _cacheService = cacheService;

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
                RefreshTokenExpiresAtUtc = null,
                LastPasswordChangeAt = DateTime.Now,
            };

            user.UserSettings = new UserSettings
            {
                ReceiveEmails = true,
            };

            if (request.ImageBase64 != null)
            {
                var uploadedFile = await _storageService.UploadFileAsync(request.ImageFileName!, request.ImageBase64, cancellationToken);

                user.Image = uploadedFile.FileName;
            }

            await _dbContext.Users.AddAsync(user, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            SendWelcomeMail(user);

            return _mapper.Map<UserGetDto>(user);
        }

        public async Task<UserGetDto> GetUserByIdAsync(long id, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users
                .Include(x => x.UserCredentials)
                .Include(x => x.UserSettings)
                .AsNoTracking().FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            var response = _mapper.Map<UserGetDto>(user);

            response.Username = user.UserCredentials!.Username;

            return response;
        }

        public async Task ChangePasswordAsync(long id, ChangePasswordDto request, CancellationToken cancellationToken)
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
                    RefreshTokenExpiresAtUtc = null,
                    LastPasswordChangeAt = DateTime.Now,
                };
            }
            else
            {
                _backgroundJobClient.Enqueue<IUserCredentialService>(x => x.GenerateCredentialAndSendEmailAsync(id, request.Username, user.Email));
            }

            await _dbContext.SaveChangesAsync();
        }

        public async Task<PagedResponse<ReviewGetDto>> GetUsersReviewsPagedAsync(GetUserReviewsRequest request, CancellationToken cancellationToken)
        {
            var loggedUserId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.GuestReviews.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<GuestReview>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var reviews = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<GuestReview, bool>> FilterExpression)>()
                {
                    (true, x => x.GuestId == loggedUserId)
                },
                GetUsersReviewOrderByExpression(pagingRequest.OrderByColumn),
                x => new ReviewGetDto
                {
                    Id = x.Review.Id,
                    Note = x.Review.Note,
                    Rating = x.Review.Rating,
                    Reviewer = _dbContext.Users.First(u => u.Id == x.Review.CreatedBy).GetFullName(),
                    ReviewerImage = _dbContext.Users.FirstOrDefault(u => u.Id == x.Review.CreatedBy) != null ? _dbContext.Users.First(u => u.Id == x.Review.CreatedBy).Image : null,
                    MinutesAgo = Math.Floor((DateTime.UtcNow - x.Review.CreatedAt).TotalMinutes),
                    HoursAgo = Math.Floor((DateTime.UtcNow - x.Review.CreatedAt).TotalHours),
                    DaysAgo = Math.Floor((DateTime.UtcNow - x.Review.CreatedAt).TotalDays)
                }, cancellationToken);

            return reviews;
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

            if (request.ImageBase64 != null)
            {
                var uploadedFile = await _storageService.UploadFileAsync(request.ImageFileName!, request.ImageBase64, cancellationToken);

                user.Image = uploadedFile.FileName;
            }

            _dbContext.Update(user);

            await _dbContext.SaveChangesAsync(cancellationToken);

            var response = _mapper.Map<UserGetDto>(user);

            response.Username = user.UserCredentials!.Username;

            response.Role = _mapper.Map<RoleGetDto>(user.Role);

            response.UserSettings = _mapper.Map<UserSettingsGetDto>(user.UserSettings);

            return response;
        }

        public async Task<ReviewGetDto> CreateReviewAsync(long id, ReviewCreateDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            var ownerId = _jwtTokenReader.GetUserIdFromToken();

            var wasPreviouslyGuest = await _dbContext.Reservations
                .Include(x => x.AccommodationUnit)
                .AsNoTracking()
                .AnyAsync(x => x.UserId == user.Id && x.Status == ReservationStatus.Completed
                && x.AccommodationUnit.OwnerId == ownerId);

            if (!wasPreviouslyGuest)
            {
                throw new DomainException("NotGuest", "Ne možete napraviti recenziju za korisnika koji nije bio gost Vašeg objekta.");
            }

            var review = _mapper.Map<Review>(request);

            await _dbContext.AddAsync(review, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            var userReview = new AccommodationUnitReview
            {
                AccommodationUnitId = id,
                ReviewId = review.Id,
            };

            await _dbContext.AddAsync(userReview, cancellationToken);

            await _dbContext.SaveChangesAsync(cancellationToken);

            if (user.UserSettings!.ReceiveNotifications) {

                _backgroundJobClient.Enqueue<INotifyService>(x => x.NotifyUserAboutNewReview(user.Id));
            }

            return _mapper.Map<ReviewGetDto>(review);
        }

        public async Task<UserSettingsGetDto> UpdateSettingsAsync(long id, UpdateSettingsDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Set<User>().Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            user.UserSettings!.ReceiveEmails = request.ReceiveEmails;
            user.UserSettings!.ReceiveNotifications = request.ReceiveNotifications;
            user.UserSettings!.MarkObjectAsUncleanAfterReservation = request.MarkObjectAsUncleanAfterReservation;

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<UserSettingsGetDto>(user.UserSettings);
        }

        public async Task RequestForgottenPasswordCodeAsync(RequestResetPasswordCodeDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Email == request.Email, cancellationToken);

            NotFoundException.ThrowIfNull(user, "Korisnik sa navedenim e-mailom nije pronađen!");

            var code = GenerateCode();

            var mail = new MailCreateDto
            {
                Subject = "Zaboravljena lozinka",
                Content = $"Poštovani {user.GetFullName()}, primljen je zahtjev za promjenom Vaše lozinke. Ovdje je kod koji Vam omogućava reset lozinke: {code}" +
                $"Molimo Vas da unesete ovaj kod u aplikaciju kako biste započeli proces reseta lozinke. " +
                $"Imajte na umu da je kod aktivan narednih 5 minuta. Hvala na strpljenju i razumijevanju." +
                $"S poštovanjem, eRezerviši administracija",
                Sender = _mailConfig.Username,
                Recipient = request.Email,
            };

            _rabbitMQProducer.SendMessage(mail);

            _cacheService.SetData($"forgotten-password-{request.Email}", code, TimeSpan.FromMinutes(5));
        }

        public async Task CheckForgottenPasswordCodeAsync(CheckForgottenPasswordCodeDto request, CancellationToken cancellationToken)
        {
            var validationCode = _cacheService.GetData($"forgotten-password-{request.Email}");

            NotFoundException.ThrowIfNull(validationCode, "Kod je istekao!");

            if ((long)validationCode != request.Code)
            {
                throw new DomainException("IncorrectCode", "Kod koji ste unijeli nije validan!");
            }

            await Task.CompletedTask;
        }

        public async Task ResetPasswordAsync(ResetPasswordDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Email == request.Email, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            var passwordSalt = Guid.NewGuid().ToString("N");

            var passwordHash = _hashService.GenerateHash(request.NewPassword, passwordSalt);

            user.UserCredentials!.LastPasswordChangeAt = DateTime.Now;
            user.UserCredentials.PasswordHash = passwordHash;
            user.UserCredentials.PasswordSalt = passwordSalt;

            await _dbContext.SaveChangesAsync(cancellationToken);
        }

        public async Task<bool> CheckUsernameAsync(CheckUsernameDto request, CancellationToken cancellationToken)
        {
            var usernameExists = await _dbContext.Users
                .Include(x => x.UserCredentials)
                .AnyAsync(x => (!request.UserId.HasValue || x.Id == request.UserId) && x.UserCredentials!.Username == request.Username, cancellationToken);

            return usernameExists;
        }

        public async Task<bool> CheckEmailAsync(CheckEmailDto request, CancellationToken cancellationToken)
        {
            var emailExists = await _dbContext.Users
                .AnyAsync(x => (!request.UserId.HasValue || x.Id == request.UserId) && x.Email == request.Email, cancellationToken);

            return emailExists;
        }

        public async Task<bool> CheckPhoneNumberAsync(CheckPhoneNumberDto request, CancellationToken cancellationToken)
        {
            var phoneNumberExists = await _dbContext.Users
                .AnyAsync(x => (!request.UserId.HasValue || x.Id == request.UserId) && x.Phone == request.PhoneNumber, cancellationToken);

            return phoneNumberExists;
        }

        private long GenerateCode()
        {
            using var generator = RandomNumberGenerator.Create();
            var bytes = new byte[8];
            generator.GetBytes(bytes);

            return (BitConverter.ToInt64(bytes, 0) & long.MaxValue) % 900000 + 100000;
        }

        private void SendWelcomeMail(User user)
        {
            var mail = new MailCreateDto
            {
                Subject = "Mail dobrodošlice.",
                Content = "Dobro došli u eRezerviši",
                Recipient = user.Email,
                Sender = _mailConfig.Username
            };

            _rabbitMQProducer.SendMessage(mail);
        }

        private Expression<Func<GuestReview, object>> GetUsersReviewOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "createdAt":
                    return x => x.Review.CreatedAt;
                default:
                    return x => x.ReviewId;
            }
        }
    }
}
