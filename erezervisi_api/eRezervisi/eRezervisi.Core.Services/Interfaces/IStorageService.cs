using eRezervisi.Common.Dtos.Storage;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IStorageService
    {
        Task<UploadedFileGetDto> UploadFileAsync(string fileName, string base64File, CancellationToken cancellationToken);
        Task DeleteFileAsync(string fileName, CancellationToken cancellationToken);
    }
}
