namespace eRezervisi.Common.Dtos.Message
{
    public class MessageCreateDto
    {
        public long ReceiverId { get; set; }
        public string Content { get; set; } = null!;
    }
}