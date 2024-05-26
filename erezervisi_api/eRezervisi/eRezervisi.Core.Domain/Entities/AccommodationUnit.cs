using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Domain.Entities
{
    public class AccommodationUnit : BaseEntity<long>
    {
        public string Title { get; set; } = null!;
        public string ShortTitle { get; set; } = null!;
        public double Price { get; set; }
        public List<Image> Images { get; set; } = [];
        public User Owner { get; set; } = null!;
        public long OwnerId { get; set; }
        public string? Note { get; set; }
        public AccommodationUnitPolicy AccommodationUnitPolicy { get; set; } = null!;
        public long AccommodationUnitCategoryId { get; set; }
        public AccommodationUnitCategory AccommodationUnitCategory { get; set; } = null!;
        public ICollection<AccommodationUnitReview>? Reviews { get; set; }
        public double? AverageRating => Reviews?.Average(x => x.Review.Rating);
        public AccommodationUnitStatus Status { get; set; }
        public long TownshipId { get; set; }
        public Township Township { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public long ThumbnailImageId { get; set; }
        public Image ThumbnailImage { get; set; } = null!;

        public AccommodationUnit() { }

        public void ChangeStatus(AccommodationUnitStatus status)
        {
            Status = status;
        }
    }
}
