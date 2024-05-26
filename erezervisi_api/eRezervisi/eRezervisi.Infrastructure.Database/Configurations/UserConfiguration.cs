using eRezervisi.Core.Domain.Authorization;
using eRezervisi.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace eRezervisi.Infrastructure.Database.Configurations
{
    internal class UserConfiguration : BaseEntityTypeBuilder<User>, IEntityTypeConfiguration<User>
    {
        public override void Configure(EntityTypeBuilder<User> builder)
        {
            base.Configure(builder);

            builder.ToTable("users");

            builder.Property(x => x.FirstName);

            builder.Property(x => x.LastName);

            builder.Property(x => x.Phone).HasDefaultValue("");

            builder.Property(x => x.Email).HasDefaultValue("");

            builder.Property(x => x.Image).IsRequired(false);

            builder.Property(x => x.RoleId);

            builder.HasOne<Role>(x => x.Role).WithMany().HasForeignKey(x => x.RoleId);

            builder.Property(x => x.IsActive).HasDefaultValue(false);

            builder.OwnsOne(x => x.UserCredentials, x =>
            {
                x.ToTable("user_credentials");

                x.HasKey(x => x.UserId);

                x.WithOwner().HasForeignKey(x => x.UserId);

                x.Property(y => y.Username);

                x.Property(y => y.PasswordSalt);

                x.Property(y => y.PasswordHash);

                x.Property(y => y.RefreshToken).IsRequired(false);

                x.Property(y => y.RefreshTokenExpiresAtUtc).IsRequired(false);

                x.HasIndex(y => y.Username).IsUnique();

                x.HasIndex(y => y.RefreshToken).IsUnique();
            });


            builder.OwnsOne(x => x.UserSettings, x =>
            {
                x.ToTable("user_settings");

                x.HasKey(x => x.UserId);

                x.WithOwner().HasForeignKey(x => x.UserId);

                x.Property(y => y.SendReminderAt).IsRequired(false);

                x.Property(y => y.RecieveEmails).HasDefaultValue(true);
            });
        }
    }
}
