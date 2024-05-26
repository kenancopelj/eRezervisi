using eRezervisi.Common.Dtos.Irregularity;
using eRezervisi.Common.Shared;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;

namespace eRezervisi.Core.Services
{
    public class IrregularityService : IIrregularityService
    {
        private readonly eRezervisiDbContext _dbContext;

        public IrregularityService(eRezervisiDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public Task<IrregularityGetDto> SubmitIrregularityAsync(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IrregularityGetDto> UpdateIrregularityAsync(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
