using eRezervisi.Core.Domain.Entities;
using eRezervisi.Core.Domain.Enums;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class NotificationConfiguration : BaseEntityTypeBuilder<Notification>, IEntityTypeConfiguration<Notification>
    {
        public override void Configure(EntityTypeBuilder<Notification> builder)
        {
            base.Configure(builder);

            builder.ToTable("notifications");

            builder.HasOne<User>(x => x.User).WithMany().HasForeignKey(x => x.UserId);

            builder.Property(x => x.Title);

            builder.Property(x => x.Description).IsRequired(false);

            builder.Property(x => x.Status).HasDefaultValueSql("1");

            builder.Property(x => x.Type).HasDefaultValueSql("3");

            builder.Property(x => x.AccommodationUnitId).IsRequired(false);
        }
    }
}
