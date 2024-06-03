using eRezervisi.Common.Dtos.Storage;
using eRezervisi.Core.Domain.Enums;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Common.Configuration;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.Extensions.Options;
using System.Reflection;

namespace eRezervisi.Core.Services
{
    public class StorageService : IStorageService
    {
        private readonly StorageOptions _storageOptions;
        public StorageService(IOptionsSnapshot<StorageOptions> storageOptions)
        {
            _storageOptions = storageOptions.Value;
        }

        public async Task<FileDetails?> DownloadFileAsync(FileType fileType, string fileName, CancellationToken cancellationToken)
        {
            try
            {
                var folderName = GetFolderName(fileType);

                var fileFullPath = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location)!, folderName, fileName);

                var bytes = await File.ReadAllBytesAsync(fileFullPath, cancellationToken);

                const string DefaultContentType = "application/octet-stream";

                var provider = new FileExtensionContentTypeProvider();

                if (!provider.TryGetContentType(fileName, out string? contentType))
                {
                    contentType = DefaultContentType;
                }

                return new FileDetails
                {
                    Bytes = bytes,
                    FileName = fileName,
                    ContentType = contentType,
                };
            }
            catch (Exception)
            {
                return null;
            }
        }

        public async Task<UploadedFileGetDto> UploadFileAsync(FileType fileType, string fileName, string base64File, CancellationToken cancellationToken)
        {
            var files = new List<(string Path, string FileName)>();

            var folderName = GetFolderName(fileType);

            var uploadsFolder = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location)!, folderName);

            var uniqueFileName = Guid.NewGuid().ToString() + "_" + fileName;

            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }

            var filePath = Path.Combine(uploadsFolder, uniqueFileName);

            using var ms = new MemoryStream(Convert.FromBase64String(base64File));

            ms.Position = 0;

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await ms.CopyToAsync(stream);
            }

            return new UploadedFileGetDto
            {
                FileName = fileName,
            };
        }

        private string GetFolderName(FileType fileType)
        {
            return fileType switch
            {
                FileType.UserLogo => _storageOptions.UserLogosFolderName,
                FileType.AccommodationUnitLogo => _storageOptions.AccommodationUnitLogosFolderName,
                _ => throw new NotImplementedException()
            };
        }
    }
}
