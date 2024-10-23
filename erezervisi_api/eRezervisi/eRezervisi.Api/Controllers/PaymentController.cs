using eRezervisi.Common.Shared.Requests.Payment;
using eRezervisi.Infrastructure.Common.Configuration;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Stripe;

namespace eRezervisi.Api.Controllers
{
    [Route("payments")]
    [ApiController]
    public class PaymentController : BaseController<PaymentController>
    {
        private readonly StripeConfig _stripeConfig;

        public PaymentController(IOptionsSnapshot<StripeConfig> stripeConfig)
        {
            _stripeConfig = stripeConfig.Value;
            StripeConfiguration.ApiKey = _stripeConfig.SecretKey;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreatePaymentIntent([FromBody] PaymentIntentRequest request)
        {
            var service = new PaymentIntentService();

            var options = new PaymentIntentCreateOptions
            {
                Amount = request.Amount,
                Currency = "BAM",
            };

            var paymentIntent = await service.CreateAsync(options);

            return Ok(new
            {
                Id = paymentIntent.Id,
                ClientSecret = paymentIntent.ClientSecret
            });
        }
    }
}
