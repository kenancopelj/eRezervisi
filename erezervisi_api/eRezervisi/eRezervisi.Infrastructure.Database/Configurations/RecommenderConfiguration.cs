using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class RecommenderConfiguration : BaseEntityTypeBuilder<Recommender>, IEntityTypeConfiguration<Recommender>
    {
        public override void Configure(EntityTypeBuilder<Recommender> builder)
        {
            base.Configure(builder);

            builder.ToTable("recommenders");

            builder.HasKey(x => x.Id);

            builder.Property(x => x.AccommodationUnitId);

            builder.Property(x => x.FirstAccommodationUnitId);

            builder.Property(x => x.SecondAccommodationUnitId);

            builder.Property(x => x.ThirdAccommodationUnitId);
        }
    }
}
