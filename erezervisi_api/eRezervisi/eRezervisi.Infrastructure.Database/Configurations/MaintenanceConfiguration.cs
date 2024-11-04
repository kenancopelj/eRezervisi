using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class MaintenanceConfiguration : IEntityTypeConfiguration<Maintenance>
    {
        public void Configure(EntityTypeBuilder<Maintenance> builder)
        {
            builder.ToTable("maintenances");

            builder.HasKey(x => x.Id);

            builder.Property(x => x.Note);

            builder.Property(x => x.Status);

            builder.Property(x => x.Priority);

            builder.HasOne<AccommodationUnit>(x => x.AccommodationUnit).WithMany().HasForeignKey(x => x.AccommodationUnitId);
        }
    }
}
