using eRezervisi.Api.Authorization;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eRezervisi.Api.Controllers
{
    [Route("files")]
    [ApiController]
    public class FileController : BaseController<FileController>
    {
        private readonly IStorageService _storageService;

        public FileController(IStorageService storageService)
        {
            _storageService = storageService;
        }

        [RequestSizeLimit(100_000_000)]
        [HttpGet]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        [Route("download-user-logo/{fileName}")]
        public async Task<IActionResult> DownloadUserLogoAsync(string fileName, CancellationToken cancellationToken)
        {
            var result = await _storageService.DownloadFileAsync(FileType.UserLogo, fileName, cancellationToken);

            if (result is null)
            {
                return NotFound("Resurs nije pronađen");
            }

            Response.Headers.Append("Content-Disposition", "inline");

            return File(result.Bytes, result.ContentType);
        }

        [RequestSizeLimit(100_000_000)]
        [HttpGet]
        [CustomAuthorize(Roles.Owner.Name, Roles.MobileUser.Name)]
        [Route("download-accommodation-unit-logo/{fileName}")]
        public async Task<IActionResult> DownloadAccommodationUnitLogoAsync(string fileName, CancellationToken cancellationToken)
        {
            var result = await _storageService.DownloadFileAsync(FileType.AccommodationUnitLogo, fileName, cancellationToken);

            if (result is null)
            {
                return NotFound("Resurs nije pronađen");
            }

            Response.Headers.Append("Content-Disposition", "inline");

            return File(result.Bytes, result.ContentType);
        }
    }
}
