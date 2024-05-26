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

            //modelBuilder.Entity<User>().HasData(
            //    new User
            //    {
            //        Id = 1,
            //        FirstName = "Owner",
            //        LastName = "User",
            //        Phone = "0000",
            //        Address = "0000",
            //        Email = "kenan.copelj@xsoft.ba",
            //        RoleId = Roles.Owner.Id,
            //        UserCredentials = new UserCredentials
            //        {
            //            PasswordSalt = new Guid().ToString(),
            //            PasswordHash = "d5a46c7224810ce14a50ca129158f72ab583a4b0af3f3c577de3f96369f59c9b",
            //        }
            //    });

            #endregion

        }
    }
}
