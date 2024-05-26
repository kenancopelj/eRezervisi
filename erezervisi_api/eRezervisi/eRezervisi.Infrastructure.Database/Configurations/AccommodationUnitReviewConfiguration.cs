using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class AccommodationUnitReviewConfiguration : IEntityTypeConfiguration<AccommodationUnitReview>
    {
        public void Configure(EntityTypeBuilder<AccommodationUnitReview> builder)
        {
            builder.ToTable("accommodation_unit_reviews");

            builder.HasKey(x => new { x.ReviewId, x.AccommodationUnitId });

            builder.HasOne<Review>(x => x.Review).WithMany().HasForeignKey(x => x.ReviewId);

            builder.HasOne<AccommodationUnit>(x => x.AccommodationUnit).WithMany().HasForeignKey(x => x.AccommodationUnitId);
        }
    }
}
