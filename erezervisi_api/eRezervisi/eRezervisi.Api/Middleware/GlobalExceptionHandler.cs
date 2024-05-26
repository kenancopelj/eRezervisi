using eRezervisi.Common.Shared;
using eRezervisi.Core.Domain.Exceptions;
using FluentValidation;
using Microsoft.AspNetCore.Mvc;
using System.Net;
using System.Text.Json;

namespace eRezervisi.Api.Middleware
{
    public class GlobalExceptionHandler
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<GlobalExceptionHandler> _logger;

        public GlobalExceptionHandler(RequestDelegate next,
            ILogger<GlobalExceptionHandler> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occured.");

                context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                context.Response.ContentType = "application/json";

                switch (ex)
                {
                    case NotFoundException:
                        context.Response.StatusCode = (int)HttpStatusCode.NotFound;

                        await context.Response.WriteAsync(JsonSerializer.Serialize(new { Error = ex.Message }));

                        break;

                    case DuplicateException:
                        context.Response.StatusCode = (int)HttpStatusCode.Conflict;

                        await context.Response.WriteAsync(JsonSerializer.Serialize(new { Error = ex.Message }));

                        break;

                    case DomainException:
                        context.Response.StatusCode = (int)HttpStatusCode.UnprocessableEntity;

                        await context.Response.WriteAsync(JsonSerializer.Serialize(new { Code = ((DomainException)ex).Code, Error = ex.Message, Payload = ((DomainException)ex).Payload }));

                        break;

                    case ValidationException:
                        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;

                        var validationException = (ValidationException)ex;

                        var errors = validationException.Errors
                            .Select(x => new { x.PropertyName, x.ErrorMessage })
                            .GroupBy(x => x.PropertyName)
                            .ToDictionary(x => x.Key, x => x.ToList().Select(y => y.ErrorMessage).ToArray());

                        await context.Response.WriteAsync(JsonSerializer.Serialize(new ValidationProblemDetails(errors)));

                        break;

                    default:
                        await context.Response.WriteAsync(JsonSerializer.Serialize(new { StatusCode = context.Response.StatusCode, Message = "Greška na serveru." }));

                        break;
                }
            }
        }
    }
}
