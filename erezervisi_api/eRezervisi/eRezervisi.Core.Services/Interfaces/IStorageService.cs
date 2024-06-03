using eRezervisi.Common.Dtos.Storage;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IStorageService
    {
        Task<UploadedFileGetDto> UploadFileAsync(FileType fileType, string fileName, string base64File, CancellationToken cancellationToken);
        Task<FileDetails?> DownloadFileAsync(FileType fileType, string filePath, CancellationToken cancellationToken);
    }
}
