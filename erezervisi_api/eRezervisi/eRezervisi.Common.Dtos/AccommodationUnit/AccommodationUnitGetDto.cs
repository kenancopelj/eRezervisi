using eRezervisi.Common.Dtos.AccommodationUnitPolicy;

namespace eRezervisi.Common.Dtos.AccommodationUnit
{
    public class AccommodationUnitGetDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = null!;
        public double Price { get; set; }
        public string? Note { get; set; }
        public PolicyGetDto Policy { get; set; } = null!;
        public string CategoryTitle { get; set; } = null!;
        public string TownshipTitle { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
    }
}
