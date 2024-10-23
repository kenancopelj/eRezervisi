using AutoMapper;
using eRezervisi.Common.Dtos.Mail;
using eRezervisi.Common.Dtos.Review;
using eRezervisi.Common.Dtos.Role;
using eRezervisi.Common.Dtos.User;
using eRezervisi.Common.Dtos.UserSettings;
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

        public UserService(eRezervisiDbContext dbContext,
            IHashService hashService,
            IMapper mapper,
            IBackgroundJobClient backgroundJobClient,
            IStorageService storageService,
            IJwtTokenReader jwtTokenReader,
            IRabbitMQProducer rabbitMQProducer,
            IOptionsSnapshot<MailConfig> mailConfig)
        {
            _dbContext = dbContext;
            _hashService = hashService;
            _mapper = mapper;
            _backgroundJobClient = backgroundJobClient;
            _storageService = storageService;
            _jwtTokenReader = jwtTokenReader;
            _rabbitMQProducer = rabbitMQProducer;
            _mailConfig = mailConfig.Value;
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
                    RefreshTokenExpiresAtUtc = null,
                    LastPasswordChangeAt = DateTime.Now,
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
            var user = await _dbContext.Users.FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

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

            return _mapper.Map<ReviewGetDto>(review);
        }

        public async Task<UserSettingsGetDto> UpdateSettingsAsync(long id, UpdateSettingsDto request, CancellationToken cancellationToken)
        {
            var user = await _dbContext.Set<User>().Include(x => x.UserSettings).FirstOrDefaultAsync(x => x.Id == id, cancellationToken);

            NotFoundException.ThrowIfNull(user);

            user.UserSettings = _mapper.Map<UserSettings>(request);

            await _dbContext.SaveChangesAsync(cancellationToken);

            return _mapper.Map<UserSettingsGetDto>(user.UserSettings);
        }

        public async Task<GetReviewsResponse> GetReviewsByUserAsync(CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var user = await _dbContext.Users.FirstAsync(x => x.Id == userId);

            var accommodationUnitReviews = await _dbContext.AccommodationUnitReviews
               .Include(x => x.Review)
               .AsNoTracking()
               .Where(x => x.Review.CreatedBy == userId)
               .Select(x => new ReviewGetDto
               {
                   Id = x.Review.Id,
                   Title = x.Review.Title,
                   Note = x.Review.Note,
                   Rating = x.Review.Rating,
                   ReviewerId = userId,
                   Reviewer = user.GetFullName()
               })
               .ToListAsync(cancellationToken);

            var guestReviews = await _dbContext.GuestReviews
               .Include(x => x.Review)
               .AsNoTracking()
               .Where(x => x.Review.CreatedBy == userId)
               .Select(x => new ReviewGetDto
               {
                   Id = x.Review.Id,
                   Title = x.Review.Title,
                   Note = x.Review.Note,
                   Rating = x.Review.Rating,
               })
               .ToListAsync(cancellationToken);

            accommodationUnitReviews.AddRange(guestReviews);

            accommodationUnitReviews = accommodationUnitReviews.OrderBy(_ => Guid.NewGuid()).ToList();

            return new GetReviewsResponse
            {
                Reviews = accommodationUnitReviews
            };
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
    }
}
