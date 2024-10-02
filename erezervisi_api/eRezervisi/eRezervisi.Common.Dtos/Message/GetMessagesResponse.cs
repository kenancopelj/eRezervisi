namespace eRezervisi.Common.Dtos.Message
{
    public class GetMessagesResponse 
    {
        public List<MessageGetDto> Messages { get; set; } = new();
    }
}
