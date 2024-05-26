using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class ReviewConfiguration : BaseEntityTypeBuilder<Review>, IEntityTypeConfiguration<Review>
    {
        public override void Configure(EntityTypeBuilder<Review> builder)
        {
            base.Configure(builder);

            builder.ToTable("reviews");

            builder.Property(x => x.Title);

            builder.Property(x => x.Rating);

            builder.Property(x => x.Note);
        }
    }
}
