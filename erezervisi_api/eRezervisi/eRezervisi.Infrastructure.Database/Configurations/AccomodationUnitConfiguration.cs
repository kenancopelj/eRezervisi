using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class AccommodationUnitConfiguration : BaseEntityTypeBuilder<AccommodationUnit>, IEntityTypeConfiguration<AccommodationUnit>
    {
        public override void Configure(EntityTypeBuilder<AccommodationUnit> builder)
        {
            base.Configure(builder);

            builder.ToTable("accommodation_units");

            builder.Property(x => x.Title);

            builder.Property(x => x.Price);

            builder.Property(x => x.OwnerId);

            builder.Property(x => x.Note).IsRequired(false);

            builder.Property(x => x.ThumbnailImage);

            builder.OwnsOne(x => x.AccommodationUnitPolicy, x =>
            {
                x.ToTable("accommodation_unit_policies");

                x.WithOwner().HasForeignKey(x => x.AccommodationUnitId);

                x.Property(y => y.AlcoholAllowed);

                x.Property(y => y.BirthdayPartiesAllowed);

                x.Property(y => y.HasPool);

                x.Property(y => y.Capacity);
            });

            builder.HasOne<AccommodationUnitCategory>(x => x.AccommodationUnitCategory).WithMany().HasForeignKey(x => x.AccommodationUnitCategoryId);

            builder.Property(x => x.Status);

            builder.HasOne<Township>(x => x.Township).WithMany().HasForeignKey(x => x.TownshipId);

            builder.HasMany<Image>(x => x.Images).WithOne(i => i.AccommodationUnit).HasForeignKey(x => x.AccommodationUnitId);

            builder.Property(x => x.Latitude);

            builder.Property(x => x.Longitude);

            builder.Property(x => x.Address);

            builder.Property(x => x.ViewCount).HasDefaultValue(0);
        }
    }
}
