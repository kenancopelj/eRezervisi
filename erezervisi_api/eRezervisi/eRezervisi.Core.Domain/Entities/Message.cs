namespace eRezervisi.Core.Domain.Entities
{
    public class Message : BaseEntity<long>
    {
        public long SenderId { get; set; }
        public User Sender { get; set; } = null!;
        public long RecieverId { get; set; }
        public User Reciever { get; set; } = null!;
        public string Content { get; set; } = null!;
    }
}
