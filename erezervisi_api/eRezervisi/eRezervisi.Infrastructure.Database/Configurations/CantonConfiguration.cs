using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class CantonConfiguration : BaseEntityTypeBuilder<Canton>, IEntityTypeConfiguration<Canton>
    {
        public override void Configure(EntityTypeBuilder<Canton> builder)
        {
            base.Configure(builder);

            builder.ToTable("cantons");

            builder.Property(x => x.Title);

            builder.Property(x => x.ShortTitle);
        }
    }
}
