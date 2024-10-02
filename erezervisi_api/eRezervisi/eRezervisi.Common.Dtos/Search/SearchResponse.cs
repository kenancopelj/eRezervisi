using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Common.Dtos.User;

namespace eRezervisi.Common.Dtos.Search
{
    public class SearchResponse
    {
        public List<AccommodationUnitGetShortDto> AccommodationUnits { get; set; } = new();
        public List<UserGetShortDto> Users { get; set; } = new();
    }
}
