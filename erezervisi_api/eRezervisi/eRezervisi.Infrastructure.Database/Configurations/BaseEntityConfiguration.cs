using eRezervisi.Core.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class BaseEntityTypeBuilder<TEntity> where TEntity : class, IBaseEntity<long>
    {
        public virtual void Configure(EntityTypeBuilder<TEntity> builder)
        {
            builder.Property(x => x.Id).UseIdentityColumn().HasColumnName("id");

            builder.Property(x => x.CreatedAt).HasDefaultValueSql("GETUTCDATE()");

            builder.Property(x => x.ModifiedAt).HasDefaultValueSql("GETUTCDATE()");

            builder.Property(x => x.DeletedAt).IsRequired(false);
            
            builder.Property(x => x.DeletedBy).IsRequired(false);

            builder.Property(x => x.Deleted).HasDefaultValue(false);
        }
    }
}
