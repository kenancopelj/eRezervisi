using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class AccommodationUnitCategoryConfiguration : BaseEntityTypeBuilder<AccommodationUnitCategory>, IEntityTypeConfiguration<AccommodationUnitCategory>
    {
        public override void Configure(EntityTypeBuilder<AccommodationUnitCategory> builder)
        {
            base.Configure(builder);

            builder.ToTable("accommodation_unit_categories");

            builder.Property(x => x.Title);

            builder.Property(x => x.ShortTitle);
        }
    }
}
