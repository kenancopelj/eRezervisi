using eRezervisi.Common.Dtos.Irregularity;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface IIrregularityService
    {
        Task<IrregularityGetDto> SubmitIrregularityAsync(CancellationToken cancellationToken);
        Task<IrregularityGetDto> UpdateIrregularityAsync(CancellationToken cancellationToken);
    }
}
