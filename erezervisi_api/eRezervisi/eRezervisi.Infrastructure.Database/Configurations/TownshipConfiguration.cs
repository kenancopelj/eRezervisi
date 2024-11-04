using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class TownshipConfiguration : BaseEntityTypeBuilder<Township>, IEntityTypeConfiguration<Township>
    {
        public override void Configure(EntityTypeBuilder<Township> builder)
        {
            base.Configure(builder);

            builder.ToTable("townships");

            builder.Property(x => x.Title);

            builder.HasOne(x => x.Canton).WithMany().HasForeignKey(x => x.CantonId);
        }
    }
}
