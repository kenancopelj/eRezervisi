namespace eRezervisi.Core.Domain.Entities
{
    public class Message : BaseEntity<long>
    {
        public long SenderId { get; set; }
        public User Sender { get; set; } = null!;
        public long ReceiverId { get; set; }
        public User Receiver { get; set; } = null!;
        public string Content { get; set; } = null!;
    }
}
