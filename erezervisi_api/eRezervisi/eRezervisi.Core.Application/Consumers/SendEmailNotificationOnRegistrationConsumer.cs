using eRezervisi.Core.Services.Interfaces;
using MassTransit;

namespace eRezervisi.Core.Application.Consumers
{
    public class SendEmailNotificationOnRegistrationConsumer : IConsumer<SendEmailNotificationOnRegistrationConsumer>
    {
        private readonly IMailService

        public Task Consume(ConsumeContext<SendEmailNotificationOnRegistrationConsumer> context)
        {
        }
    }
}
