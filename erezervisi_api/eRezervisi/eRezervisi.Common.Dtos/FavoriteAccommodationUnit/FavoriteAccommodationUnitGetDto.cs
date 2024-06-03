using eRezervisi.Common.Dtos.AccommodationUnit;

namespace eRezervisi.Common.Dtos.FavoriteAccommodationUnit
{
    public class FavoriteAccommodationUnitGetDto
    {
        public long Id { get; set; }
        public long AcoommodationUnitId { get; set; }
        public AccommodationUnitGetDto AccommodationUnit { get; set; } = null!;
    }
}
