using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class GuestReviewConfiguration : IEntityTypeConfiguration<GuestReview>
    {
        public void Configure(EntityTypeBuilder<GuestReview> builder)
        {
            builder.ToTable("guest_reviews");

            builder.HasKey(x => new { x.GuestId, x.ReviewId });

            builder.HasOne<Review>(x => x.Review).WithMany().HasForeignKey(x => x.ReviewId);

            builder.HasOne<User>(x => x.Guest).WithMany().HasForeignKey(x => x.GuestId);
        }
    }
}
