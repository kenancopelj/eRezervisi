using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class ImageConfiguration : BaseEntityTypeBuilder<Image>, IEntityTypeConfiguration<Image>
    {
        public override void Configure(EntityTypeBuilder<Image> builder)
        {
            base.Configure(builder);

            builder.ToTable("images");

            builder.Property(x => x.FileName);
        }
    }
}
