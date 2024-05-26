using eRezervisi.Core.Domain.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class RoleConfiguration : BaseEntityTypeBuilder<Role>, IEntityTypeConfiguration<Role>
    {
        public override void Configure(EntityTypeBuilder<Role> builder)
        {
            base.Configure(builder);

            builder.ToTable("roles");

            builder.Property(x => x.Name);
        }
    }
}
