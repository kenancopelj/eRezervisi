using eRezervisi.Common.Dtos.Township;
using eRezervisi.Core.Services.Interfaces;
using eRezervisi.Infrastructure.Database;

namespace eRezervisi.Core.Services
{
    public class TownshipService : ITownshipService
    {
        private readonly eRezervisiDbContext _dbContext;

        public TownshipService(eRezervisiDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public Task<GetTownshipsResponse> GetTownshipsAsync(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<GetTownshipsResponse> GetTownshipsByCantonIdAsync(CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
