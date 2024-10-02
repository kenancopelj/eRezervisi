using eRezervisi.Common.Dtos.User;

namespace eRezervisi.Common.Dtos.Message
{
    public class MessageGetDto
    {
        public long Id { get; set; }
        public long SenderId { get; set; }
        public UserGetShortDto Sender { get; set; } = null!;
        public long ReceiverId { get; set; }
        public UserGetShortDto Receiver { get; set; } = null!;
        public string Content { get; set; } = null!;
    }
}
