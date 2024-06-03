using eRezervisi.Core.Domain.Authorization;
using eRezervisi.Core.Domain.Entities;
using eRezervisi.Infrastructure.Common.Constants;
using Microsoft.EntityFrameworkCore;

namespace eRezervisi.Infrastructure.Database
{
    public static class SeedData
    {
        public static void Seed(this ModelBuilder modelBuilder)
        {
            #region Roles

            modelBuilder.Entity<Role>().HasData(
                new Role
                {
                    Id = Roles.Owner.Id,
                    Name = Roles.Owner.Name
                },
                new Role
                {
                    Id = Roles.MobileUser.Id,
                    Name = Roles.MobileUser.Name
                }
            );

            #endregion

            #region Users

            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    FirstName = "Owner",
                    LastName = "User",
                    Phone = "0000",
                    Address = "0000",
                    Email = "kenan.copelj@edu.fit.ba",
                    IsActive = true,
                    RoleId = Roles.Owner.Id,
                },
                new User
                {
                    Id = 2,
                    FirstName = "Regular",
                    LastName = "User",
                    Phone = "0000",
                    Address = "0000",
                    Email = "kenan.copelj@edu.fit.ba",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                });

            modelBuilder.Entity<User>().OwnsOne(x => x.UserSettings).HasData(
                new UserSettings
                {
                    UserId = 1,
                    RecieveEmails = true
                },
                new UserSettings
                {
                    UserId = 2,
                    RecieveEmails = true
                });

            modelBuilder.Entity<User>().OwnsOne(x => x.UserCredentials).HasData(
                new UserCredentials
                {
                    UserId = 1,
                    PasswordSalt = "a45e7aa02fd2414eb66c0c24562205ba",
                    PasswordHash = "e38fa1a920da144b4f91c910b3e8f432c1cd3a6dd27f40a8bad40317e25981cf",
                    Username = "desktop",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                    LastPasswordChangeAt = DateTime.UtcNow,
                },
                new UserCredentials
                {
                    UserId = 2,
                    PasswordSalt = "a45e7aa02fd2414eb66c0c24562205ba",
                    PasswordHash = "e38fa1a920da144b4f91c910b3e8f432c1cd3a6dd27f40a8bad40317e25981cf",
                    Username = "mobile",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                    LastPasswordChangeAt = DateTime.UtcNow,
                });

            #endregion

            #region Categories

            modelBuilder.Entity<AccommodationUnitCategory>().HasData(
                new AccommodationUnitCategory
                {
                    Id = 1,
                    Title = "Apartmani",
                    ShortTitle = "APT",
                },
                new AccommodationUnitCategory
                {
                    Id = 2,
                    Title = "Ville",
                    ShortTitle = "VIL",
                },
                new AccommodationUnitCategory
                {
                    Id = 3,
                    Title = "Vikendice",
                    ShortTitle = "VIK",
                },
                new AccommodationUnitCategory
                {
                    Id = 4,
                    Title = "Privatne kuće",
                    ShortTitle = "PRI",
                }
                );

            #endregion
        }
    }
}
