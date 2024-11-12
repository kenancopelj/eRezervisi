using eRezervisi.Common.Dtos.Storage;
using eRezervisi.Core.Services.Interfaces;

namespace eRezervisi.Core.Services
{
    public class StorageService : IStorageService
    {
        public async Task<UploadedFileGetDto> UploadFileAsync(string fileName, string base64File, CancellationToken cancellationToken)
        {
            var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "Uploads", "Images");

            var uniqueFileName = Guid.NewGuid().ToString() + "_" + fileName;

            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }

            var filePath = Path.Combine(uploadsFolder, uniqueFileName);

            var fileBytes = Convert.FromBase64String(base64File);
            await File.WriteAllBytesAsync(filePath, fileBytes, cancellationToken);

            return new UploadedFileGetDto
            {
                FileName = uniqueFileName,
                FilePath = $"/Uploads/Images/{uniqueFileName}"
            };
        }

        public async Task DeleteFileAsync(string fileName, CancellationToken cancellationToken)
        {
            var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "Uploads", "Images");

            var filePath = Path.Combine(uploadsFolder, fileName);

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            await Task.CompletedTask;
        }
    }
}