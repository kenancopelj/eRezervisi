using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class IrregularityConfiguration : BaseEntityTypeBuilder<Irregularity>, IEntityTypeConfiguration<Irregularity>
    {
        public override void Configure(EntityTypeBuilder<Irregularity> builder)
        {
            base.Configure(builder);

            builder.ToTable("irregularites");

            builder.HasOne<AccommodationUnit>(x => x.AccommodationUnit).WithMany().HasForeignKey(x => x.AccommodationUnitId);

            builder.Property(x => x.Status);

            builder.Property(x => x.File);
        }
    }
}
