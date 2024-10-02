using AutoMapper;
using eRezervisi.Common.Dtos.Message;
using eRezervisi.Common.Shared;
using eRezervisi.Common.Shared.Pagination;
using eRezervisi.Common.Shared.Requests.Message;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Services.Hubs;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using eRezervisi.Infrastructure.Database;
using Hangfire;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using System.Xml;

namespace eRezervisi.Core.Services
{
    public class MessageService : IMessageService
    {
        private readonly eRezervisiDbContext _dbContext;
        private readonly IJwtTokenReader _jwtTokenReader;
        private readonly IMapper _mapper;
        private readonly IBackgroundJobClient _backgroundJobClient;
        private readonly IHubContext<MessageHub> _hubContext;

        public MessageService(eRezervisiDbContext dbContext,
            IJwtTokenReader jwtTokenReader,
            IMapper mapper,
            IBackgroundJobClient backgroundJobClient,
            IHubContext<MessageHub> hubContext)
        {
            _dbContext = dbContext;
            _jwtTokenReader = jwtTokenReader;
            _mapper = mapper;
            _backgroundJobClient = backgroundJobClient;
            _hubContext = hubContext;
        }

        public async Task<GetMessagesResponse> GetConversationAsync(long senderId, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var messages = await _dbContext.Messages
                .AsNoTracking()
                .Include(x => x.Sender)
                .Include(x => x.Receiver)
                .Where(x => (x.SenderId == senderId && x.ReceiverId == userId) || (x.SenderId == userId && x.ReceiverId == senderId))
                .Select(x => new MessageGetDto
                {
                    Id = x.Id,
                    ReceiverId = x.ReceiverId,
                    Receiver = new Common.Dtos.User.UserGetShortDto
                    {
                        Id = x.ReceiverId,
                        FullName = x.Receiver.GetFullName(),
                        Image = x.Receiver.Image,
                        Initials = x.Receiver.Initials,
                    },
                    SenderId = x.SenderId,
                    Sender = new Common.Dtos.User.UserGetShortDto
                    {
                        Id = x.SenderId,
                        FullName = x.Sender.GetFullName(),
                        Image = x.Sender.Image,
                        Initials = x.Sender.Initials,
                    },
                    Content = x.Content,
                })
                .ToListAsync(cancellationToken);

            return new GetMessagesResponse
            {
                Messages = messages
            };
        }

        public async Task<PagedResponse<MessageGetDto>> GetMyMessagesAsync(GetMessagesRequest request, CancellationToken cancellationToken)
        {
            var userId = _jwtTokenReader.GetUserIdFromToken();

            var queryable = _dbContext.Messages.AsQueryable();

            var pagingRequest = _mapper.Map<PagedRequest<Message>>(request);
            var searchTerm = pagingRequest.SearchTermLower;

            var messages = await queryable.GetPagedAsync(pagingRequest,
                new List<(bool shouldFilter, Expression<Func<Message, bool>> filterExpression)>()
                {
                    (true, x => x.ReceiverId == userId),
                },
                GetOrderByExpression(pagingRequest.OrderByColumn),
                x => new MessageGetDto
                {
                    Id = x.Id,
                    SenderId = x.SenderId,
                    Sender = new Common.Dtos.User.UserGetShortDto
                    {
                        Id = x.SenderId,
                        FullName = x.Sender.GetFullName(),
                        Image = x.Sender.Image
                    },
                    ReceiverId = x.ReceiverId,
                    Receiver = new Common.Dtos.User.UserGetShortDto
                    {
                        Id = x.ReceiverId,
                        FullName = x.Receiver.GetFullName(),
                        Image = x.Receiver.Image
                    },
                    Content = x.Content
                }, cancellationToken);

            messages.Items = messages.Items.DistinctBy(x => x.SenderId).Select(x => new MessageGetDto
            {
                Id = x.Id,
                SenderId = x.SenderId,
                Sender = new Common.Dtos.User.UserGetShortDto
                {
                    Id = x.SenderId,
                    FullName = x.Sender.FullName,
                    Image = x.Sender.Image
                },
                ReceiverId = x.ReceiverId,
                Receiver = new Common.Dtos.User.UserGetShortDto
                {
                    Id = x.ReceiverId,
                    FullName = x.Receiver.FullName,
                    Image = x.Receiver.Image
                },
                Content = x.Content
            }).ToList();

            return messages;
        }

        public async Task<MessageGetDto> SendMessageAsync(MessageCreateDto request, CancellationToken cancellationToken)
        {
            var senderId = _jwtTokenReader.GetUserIdFromToken();

            var message = _mapper.Map<Message>(request);

            message.SenderId = senderId;

            await _dbContext.AddAsync(message, cancellationToken);

            await _dbContext.SaveChangesAsync();

            _backgroundJobClient.Enqueue<INotifyService>(x => x.NotifyAboutNewMessage(message.Id));

            await _hubContext.Clients.All.SendAsync($"{SignalRTopics.Message}#{senderId}#{request.ReceiverId}", request, cancellationToken);

            return _mapper.Map<MessageGetDto>(message);
        }


        private Expression<Func<Message, object>> GetOrderByExpression(string orderBy)
        {
            switch (orderBy)
            {
                case "createdAt":
                    return x => x.CreatedAt;
                default:
                    return x => x.Id;
            }
        }
    }
}
