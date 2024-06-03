using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    public class BaseController<T> : ControllerBase where T : class
    {
        protected ILogger<T> Logger => HttpContext.RequestServices.GetRequiredService<ILogger<T>>();
    }
}
