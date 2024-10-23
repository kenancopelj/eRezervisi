using eRezervisi.Common.Dtos.AccommodationUnitPolicy;
using eRezervisi.Common.Dtos.Image;

namespace eRezervisi.Common.Dtos.AccommodationUnit
{
    public class AccommodationUnitCreateDto
    {
        public string Title { get; set; } = null!;
        public double Price { get; set; }
        public string? Note { get; set; }
        public string Address { get; set; } = null!;
        public AccommodationUnitPolicyCreateDto Policy { get; set; } = null!;
        public long AccommodationUnitCategoryId { get; set; }
        public List<ImageCreateDto> Files { get; set; } = null!;
        public long TownshipId { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public double TapPosition { get; set; }
    }
}
