using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.AccommodationUnitPolicy;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Township;

namespace eRezervisi.Common.Dtos.AccommodationUnit
{
    public class AccommodationUnitGetDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = null!;
        public double Price { get; set; }
        public string? Note { get; set; }
        public PolicyGetDto Policy { get; set; } = null!;
        public CategoryGetDto Category { get; set; } = null!;
        public TownshipGetDto Township { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string ThumbnailImage { get; set; } = null!;
        public List<ImageGetDto> Images { get; set; } = new();
        public bool Favorite { get; set; }
    }
}
