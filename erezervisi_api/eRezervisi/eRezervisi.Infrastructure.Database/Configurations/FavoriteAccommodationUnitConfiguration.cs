using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class FavoriteAccommodationUnitConfiguration : IEntityTypeConfiguration<FavoriteAccommodationUnit>
    {
        public void Configure(EntityTypeBuilder<FavoriteAccommodationUnit> builder)
        {
            builder.ToTable("favorite_accommodation_units");

            builder.HasKey(x => new { x.UserId, x.AccommodationUnitId });

            builder.HasOne<AccommodationUnit>(x => x.AccommodationUnit).WithMany().HasForeignKey(x => x.AccommodationUnitId);

            builder.HasOne<User>(x => x.User).WithMany().HasForeignKey(x => x.UserId);
        }
    }
}
