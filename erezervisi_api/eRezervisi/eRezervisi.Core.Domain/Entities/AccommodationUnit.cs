using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Domain.Entities
{
    public class AccommodationUnit : BaseEntity<long>
    {
        public string Title { get; set; } = null!;
        public double Price { get; set; }
        public List<Image> Images { get; set; } = new();
        public User Owner { get; set; } = null!;
        public long OwnerId { get; set; }
        public string? Note { get; set; }
        public AccommodationUnitPolicy AccommodationUnitPolicy { get; set; } = null!;
        public long AccommodationUnitCategoryId { get; set; }
        public AccommodationUnitCategory AccommodationUnitCategory { get; set; } = null!;
        public ICollection<AccommodationUnitReview>? Reviews { get; set; }
        public double? AverageRating => Reviews?.Average(x => x.Review.Rating);
        public AccommodationUnitStatus Status { get; set; }
        public string ThumbnailImage { get; set; } = null!;
        public long TownshipId { get; set; }
        public Township Township { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Address { get; set; } = null!;
        public DateOnly? DeactivateAt { get; set; } // In case user wants to deactivate object, but there are still reservations in progress. Enqueue it to job
        public int ViewCount { get; set; }

        public AccommodationUnit() { }

        public void Deactivate(DateOnly date)
        {
            Status = AccommodationUnitStatus.Inactive;
            DeactivateAt = date;
        }

        public void Activate()
        {
            Status = AccommodationUnitStatus.Active;
            DeactivateAt = null;
        }

        public void View()
        {
            ViewCount++;
        }
    }
}
