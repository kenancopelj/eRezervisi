using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class ReservationConfiguration : BaseEntityTypeBuilder<Reservation>, IEntityTypeConfiguration<Reservation>
    {
        public override void Configure(EntityTypeBuilder<Reservation> builder)
        {
            base.Configure(builder);

            builder.ToTable("reservations");

            builder.HasIndex(x => new { x.Code }).IsUnique();

            builder.HasOne(x => x.User).WithMany().HasForeignKey(x => x.UserId);

            builder.HasOne(x => x.AccommodationUnit).WithMany().HasForeignKey(x => x.AccommodationUnitId);

            builder.Property(x => x.From);

            builder.Property(x => x.To);

            builder.Property(x => x.CheckedInAt).IsRequired(false);

            builder.Property(x => x.CheckedOutAt).IsRequired(false);

            builder.Property(x => x.PaymentMethod);

            builder.Property(x => x.Note).IsRequired(false);

            builder.Property(x => x.Status);

            builder.Property(x => x.NumberOfAdults);

            builder.Property(x => x.NumberOfChildren);

            builder.Property(x => x.TotalPrice);
        }
    }
}
