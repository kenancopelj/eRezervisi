namespace eRezervisi.Core.Services.Interfaces
{
    public interface IRabbitMQProducer
    {
        public void SendMessage<T>(T message);
    }
}
