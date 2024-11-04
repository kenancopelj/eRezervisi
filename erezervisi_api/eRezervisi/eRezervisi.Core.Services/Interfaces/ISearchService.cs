using eRezervisi.Common.Dtos.Search;
using eRezervisi.Common.Shared.Pagination;

namespace eRezervisi.Core.Services.Interfaces
{
    public interface ISearchService
    {
        Task<SearchResponse> SearchAsync(BaseGetAllRequest request, CancellationToken cancellationToken);
    }
}
