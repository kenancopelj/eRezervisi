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
                    Phone = "+387616161",
                    Address = "Opine b.b",
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
                    Email = "kenancopelj@outlook.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 3,
                    FirstName = "Emma",
                    LastName = "Watson",
                    Phone = "+38761234501",
                    Address = "123 Main St",
                    Email = "emma.watson@domain.com",
                    IsActive = true,
                    RoleId = Roles.Owner.Id,
                },
                new User
                {
                    Id = 4,
                    FirstName = "Liam",
                    LastName = "Johnson",
                    Phone = "+38761234502",
                    Address = "456 Elm St",
                    Email = "liam.johnson@domain.com",
                    IsActive = true,
                    RoleId = Roles.Owner.Id,
                },
                new User
                {
                    Id = 5,
                    FirstName = "Olivia",
                    LastName = "Brown",
                    Phone = "+38761234503",
                    Address = "789 Maple Ave",
                    Email = "olivia.brown@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 6,
                    FirstName = "Noah",
                    LastName = "Williams",
                    Phone = "+38761234504",
                    Address = "101 Oak Rd",
                    Email = "noah.williams@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 7,
                    FirstName = "Ava",
                    LastName = "Jones",
                    Phone = "+38761234505",
                    Address = "202 Pine St",
                    Email = "ava.jones@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 8,
                    FirstName = "Mason",
                    LastName = "Garcia",
                    Phone = "+38761234506",
                    Address = "303 Cedar Ave",
                    Email = "mason.garcia@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 9,
                    FirstName = "Sophia",
                    LastName = "Martinez",
                    Phone = "+38761234507",
                    Address = "404 Birch Blvd",
                    Email = "sophia.martinez@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 10,
                    FirstName = "Lucas",
                    LastName = "Anderson",
                    Phone = "+38761234508",
                    Address = "505 Willow Way",
                    Email = "lucas.anderson@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 11,
                    FirstName = "Amelia",
                    LastName = "Thomas",
                    Phone = "+38761234509",
                    Address = "606 Chestnut St",
                    Email = "amelia.thomas@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 12,
                    FirstName = "Ethan",
                    LastName = "Lee",
                    Phone = "+38761234510",
                    Address = "707 Spruce Ave",
                    Email = "ethan.lee@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 13,
                    FirstName = "Isabella",
                    LastName = "Davis",
                    Phone = "+38761234511",
                    Address = "808 Redwood Rd",
                    Email = "isabella.davis@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 14,
                    FirstName = "Logan",
                    LastName = "Wilson",
                    Phone = "+38761234512",
                    Address = "909 Fir Ln",
                    Email = "logan.wilson@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 15,
                    FirstName = "Mia",
                    LastName = "Hernandez",
                    Phone = "+38761234513",
                    Address = "1010 Palm St",
                    Email = "mia.hernandez@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 16,
                    FirstName = "James",
                    LastName = "Robinson",
                    Phone = "+38761234514",
                    Address = "1111 Maplewood Dr",
                    Email = "james.robinson@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                },
                new User
                {
                    Id = 17,
                    FirstName = "Harper",
                    LastName = "Clark",
                    Phone = "+38761234515",
                    Address = "1212 Pinewood Ln",
                    Email = "harper.clark@domain.com",
                    IsActive = true,
                    RoleId = Roles.MobileUser.Id,
                }

                );

            modelBuilder.Entity<User>().OwnsOne(x => x.UserSettings).HasData(
                new UserSettings
                {
                    UserId = 1,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 2,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 3,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 4,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 5,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 6,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 7,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 8,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 9,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 10,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 11,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 12,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 13,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 14,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 15,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 16,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                },
                new UserSettings
                {
                    UserId = 17,
                    ReceiveNotifications = true,
                    ReceiveEmails = true
                }
            );

            modelBuilder.Entity<User>().OwnsOne(x => x.UserCredentials).HasData(
                new UserCredentials
                {
                    UserId = 1,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "desktop",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 2,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "mobile",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 3,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "emmawatson",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 4,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "liamjohnson",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 5,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "oliviabrown",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 6,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "noahwilliams",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 7,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "avajones",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 8,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "masongarcia",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 9,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "sophiamartinez",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 10,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "lucasanderson",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 11,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "ameliathomas",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 12,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "ethanlee",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 13,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "isabelladavis",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 14,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "loganwilson",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 15,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "miahernandez",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 16,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "jamesrobinson",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
                },
                new UserCredentials
                {
                    UserId = 17,
                    PasswordSalt = "d87fb28197dc4c88a790d5c31ff4d355",
                    PasswordHash = "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a",
                    Username = "harperclark",
                    RefreshToken = null,
                    RefreshTokenExpiresAtUtc = null,
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
                },
                new AccommodationUnitCategory
                {
                    Id = 5,
                    Title = "Bungalovi",
                    ShortTitle = "BGL",
                }
                );

            #endregion

            #region Cantons

            modelBuilder.Entity<Canton>().HasData(
                new Canton
                {
                    Id = 1,
                    Title = "Unsko-sanski kanton",
                    ShortTitle = "USK",
                },
                new Canton
                {
                    Id = 2,
                    Title = "Posavski kanton",
                    ShortTitle = "PK",
                },
                new Canton
                {
                    Id = 3,
                    Title = "Tuzlanski kanton",
                    ShortTitle = "TK",
                },
                new Canton
                {
                    Id = 4,
                    Title = "Zeničko-dobojski kanton",
                    ShortTitle = "ZDK",
                },
                new Canton
                {
                    Id = 5,
                    Title = "Bosansko-podrinjski kanton",
                    ShortTitle = "BPK",
                },
                new Canton
                {
                    Id = 6,
                    Title = "Srednjobosanski kanton",
                    ShortTitle = "SBK",
                },
                new Canton
                {
                    Id = 7,
                    Title = "Herecegovačko-neretvanski kanton",
                    ShortTitle = "HNK",
                },
                new Canton
                {
                    Id = 8,
                    Title = "Zapadnohercegovački kanton",
                    ShortTitle = "ZHK",
                },
                new Canton
                {
                    Id = 9,
                    Title = "Kanton Sarajevo",
                    ShortTitle = "KS",
                },
                new Canton
                {
                    Id = 10,
                    Title = "Kanton 10",
                    ShortTitle = "K10",
                },
                new Canton
                {
                    Id = 11,
                    Title = "Republika Srpksa",
                    ShortTitle = "RS",
                });

            #endregion

            #region Townships

            #region USK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 1,
                    CantonId = 1,
                    Title = "Bihać"
                },
                new Township
                {
                    Id = 2,
                    CantonId = 1,
                    Title = "Bosanska Krupa"
                },
                new Township
                {
                    Id = 3,
                    CantonId = 1,
                    Title = "Bosanski Petrovac"
                },
                new Township
                {
                    Id = 4,
                    CantonId = 1,
                    Title = "Bužim"
                },
                new Township
                {
                    Id = 5,
                    CantonId = 1,
                    Title = "Cazin"
                },
                new Township
                {
                    Id = 6,
                    CantonId = 1,
                    Title = "Ključ"
                },
                new Township
                {
                    Id = 7,
                    CantonId = 1,
                    Title = "Sanski Most"
                },
                new Township
                {
                    Id = 8,
                    CantonId = 1,
                    Title = "Velika Kladuša"
                });
            #endregion

            #region PK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 9,
                    CantonId = 2,
                    Title = "Domaljevac-Šamac"
                },
                new Township
                {
                    Id = 10,
                    CantonId = 2,
                    Title = "Odžak"
                },
                new Township
                {
                    Id = 11,
                    CantonId = 2,
                    Title = "Orašje"
                });
            #endregion

            #region TK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 12,
                    CantonId = 3,
                    Title = "Banovići"
                },
                new Township
                {
                    Id = 13,
                    CantonId = 3,
                    Title = "Čelić"
                },
                new Township
                {
                    Id = 14,
                    CantonId = 3,
                    Title = "Doboj Istok"
                },
                new Township
                {
                    Id = 15,
                    CantonId = 3,
                    Title = "Gračanica"
                },
                new Township
                {
                    Id = 16,
                    CantonId = 3,
                    Title = "Gradačac"
                },
                new Township
                {
                    Id = 17,
                    CantonId = 3,
                    Title = "Kalesija"
                },
                new Township
                {
                    Id = 18,
                    CantonId = 3,
                    Title = "Kladanj"
                },
                new Township
                {
                    Id = 19,
                    CantonId = 3,
                    Title = "Lukavac"
                },
                new Township
                {
                    Id = 20,
                    CantonId = 3,
                    Title = "Sapna"
                },
                new Township
                {
                    Id = 21,
                    CantonId = 3,
                    Title = "Srebrenik"
                },
                new Township
                {
                    Id = 22,
                    CantonId = 3,
                    Title = "Teočak"
                },
                new Township
                {
                    Id = 23,
                    CantonId = 3,
                    Title = "Tuzla"
                },
                new Township
                {
                    Id = 24,
                    CantonId = 3,
                    Title = "Živinice"
                });

            #endregion

            #region ZDK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 25,
                    CantonId = 4,
                    Title = "Breza"
                },
                new Township
                {
                    Id = 26,
                    CantonId = 4,
                    Title = "Doboj Jug"
                },
                new Township
                {
                    Id = 27,
                    CantonId = 4,
                    Title = "Kakanj"
                },
                new Township
                {
                    Id = 28,
                    CantonId = 4,
                    Title = "Maglaj"
                },
                new Township
                {
                    Id = 29,
                    CantonId = 4,
                    Title = "Olovo"
                },
                new Township
                {
                    Id = 30,
                    CantonId = 4,
                    Title = "Tešanj"
                },
                new Township
                {
                    Id = 31,
                    CantonId = 4,
                    Title = "Usora"
                },
                new Township
                {
                    Id = 32,
                    CantonId = 4,
                    Title = "Vareš"
                },
                new Township
                {
                    Id = 33,
                    CantonId = 4,
                    Title = "Visoko"
                },
                new Township
                {
                    Id = 34,
                    CantonId = 4,
                    Title = "Zavidovići"
                },
                new Township
                {
                    Id = 35,
                    CantonId = 4,
                    Title = "Zenica"
                },
                new Township
                {
                    Id = 36,
                    CantonId = 4,
                    Title = "Žepče"
                });
            #endregion

            #region BPK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 37,
                    CantonId = 5,
                    Title = "Foča"
                },
                new Township
                {
                    Id = 38,
                    CantonId = 5,
                    Title = "Goražde"
                },
                new Township
                {
                    Id = 39,
                    CantonId = 5,
                    Title = "Pale"
                });
            #endregion

            #region SBK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 40,
                    CantonId = 6,
                    Title = "Bugojno"
                },
                new Township
                {
                    Id = 41,
                    CantonId = 6,
                    Title = "Busovača"
                },
                new Township
                {
                    Id = 42,
                    CantonId = 6,
                    Title = "Dobretići"
                },
                new Township
                {
                    Id = 43,
                    CantonId = 6,
                    Title = "Donji Vakuf"
                },
                new Township
                {
                    Id = 44,
                    CantonId = 6,
                    Title = "Fojnica"
                },
                new Township
                {
                    Id = 45,
                    CantonId = 6,
                    Title = "Gornji Vakuf-Uskoplje"
                },
                new Township
                {
                    Id = 46,
                    CantonId = 6,
                    Title = "Jajce"
                },
                new Township
                {
                    Id = 47,
                    CantonId = 6,
                    Title = "Kiseljak"
                },
                new Township
                {
                    Id = 48,
                    CantonId = 6,
                    Title = "Kreševo"
                },
                new Township
                {
                    Id = 49,
                    CantonId = 6,
                    Title = "Novi Travnik"
                },
                new Township
                {
                    Id = 50,
                    CantonId = 6,
                    Title = "Travnik"
                },
                new Township
                {
                    Id = 51,
                    CantonId = 6,
                    Title = "Vitez"
                });
            #endregion

            #region HNK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 52,
                    CantonId = 7,
                    Title = "Čapljina"
                },
                new Township
                {
                    Id = 53,
                    CantonId = 7,
                    Title = "Jablanica"
                },
                new Township
                {
                    Id = 54,
                    CantonId = 7,
                    Title = "Konjic"
                },
                new Township
                {
                    Id = 55,
                    CantonId = 7,
                    Title = "Mostar"
                },
                new Township
                {
                    Id = 56,
                    CantonId = 7,
                    Title = "Neum"
                },
                new Township
                {
                    Id = 57,
                    CantonId = 7,
                    Title = "Prozor-Rama"
                },
                new Township
                {
                    Id = 58,
                    CantonId = 7,
                    Title = "Ravno"
                },
                new Township
                {
                    Id = 59,
                    CantonId = 7,
                    Title = "Stolac"
                });
            #endregion

            #region ZHK Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 60,
                    CantonId = 8,
                    Title = "Grude"
                },
                new Township
                {
                    Id = 61,
                    CantonId = 8,
                    Title = "Ljubuški"
                },
                new Township
                {
                    Id = 62,
                    CantonId = 8,
                    Title = "Posušje"
                },
                new Township
                {
                    Id = 63,
                    CantonId = 8,
                    Title = "Široki Brijeg"
                });
            #endregion

            #region KS Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 64,
                    CantonId = 9,
                    Title = "Centar"
                },
                new Township
                {
                    Id = 65,
                    CantonId = 9,
                    Title = "Novi Grad"
                },
                new Township
                {
                    Id = 66,
                    CantonId = 9,
                    Title = "Novo Sarajevo"
                },
                new Township
                {
                    Id = 67,
                    CantonId = 9,
                    Title = "Stari Grad"
                },
                new Township
                {
                    Id = 68,
                    CantonId = 9,
                    Title = "Sarajevo"
                },
                new Township
                {
                    Id = 69,
                    CantonId = 9,
                    Title = "Hadžići"
                },
                new Township
                {
                    Id = 70,
                    CantonId = 9,
                    Title = "Ilidža"
                },
                new Township
                {
                    Id = 71,
                    CantonId = 9,
                    Title = "Ilijaš"
                },
                new Township
                {
                    Id = 72,
                    CantonId = 9,
                    Title = "Trnovo"
                },
                new Township
                {
                    Id = 73,
                    CantonId = 9,
                    Title = "Vogošća"
                });
            #endregion

            #region K10 Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 74,
                    CantonId = 10,
                    Title = "Bosansko Grahovo"
                },
                new Township
                {
                    Id = 75,
                    CantonId = 10,
                    Title = "Drvar"
                },
                new Township
                {
                    Id = 76,
                    CantonId = 10,
                    Title = "Glamoč"
                },
                new Township
                {
                    Id = 77,
                    CantonId = 10,
                    Title = "Kupres"
                },
                new Township
                {
                    Id = 78,
                    CantonId = 10,
                    Title = "Livno"
                },
                new Township
                {
                    Id = 79,
                    CantonId = 10,
                    Title = "Tomislavgrad"
                });
            #endregion

            #region RS Gradovi
            modelBuilder.Entity<Township>().HasData(
                new Township
                {
                    Id = 80,
                    CantonId = 11,
                    Title = "Banja Luka"
                },
                new Township
                {
                    Id = 81,
                    CantonId = 11,
                    Title = "Trebinje"
                },
                new Township
                {
                    Id = 82,
                    CantonId = 11,
                    Title = "Zvornik"
                },
                new Township
                {
                    Id = 83,
                    CantonId = 11,
                    Title = "Prijedor"
                },
                new Township
                {
                    Id = 84,
                    CantonId = 11,
                    Title = "Gradiška"
                },
                new Township
                {
                    Id = 85,
                    CantonId = 11,
                    Title = "Derventa"
                },
                new Township
                {
                    Id = 86,
                    CantonId = 11,
                    Title = "Bijeljina"
                },
                new Township
                {
                    Id = 87,
                    CantonId = 11,
                    Title = "Doboj"
                });
            #endregion

            #endregion

            #region AccommodationUnits

            modelBuilder.Entity<AccommodationUnit>().HasData(
               new AccommodationUnit
               {
                   Id = 1,
                   Title = "Central Vista Apartments Sarajevo",
                   AccommodationUnitCategoryId = 1,
                   Address = "Mula Mustafe Bašeskije",
                   TownshipId = 66,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 1,
                   Price = 150,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "63f06b1f-f76e-45b7-82ed-0631381f85fc_VistaSarajevoThumb.jpg",
               },
               new AccommodationUnit
               {
                   Id = 2,
                   Title = "One Love",
                   AccommodationUnitCategoryId = 2,
                   Address = "Pehlivanuša 67",
                   TownshipId = 68,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 1,
                   Price = 898,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "55899be7-94fe-40b8-84a0-b66b00b022c8_OneLoveThumb.jpg",
                   ViewCount = 10
               },
               new AccommodationUnit
               {
                   Id = 3,
                   Title = "Apartment Citta Vecchia",
                   AccommodationUnitCategoryId = 1,
                   Address = "Soldina 3",
                   TownshipId = 55,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 3,
                   Price = 369,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_CittaThumb.jpg",
                   ViewCount = 4
               },
               new AccommodationUnit
               {
                   Id = 4,
                   Title = "Villa Flumen",
                   AccommodationUnitCategoryId = 2,
                   Address = "II. bojne rudničke 185A",
                   TownshipId = 55,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 3,
                   Price = 369,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "49f38bd6-1d31-4458-997d-b5739e5d7fda_FlumenThumb.jpg",
                   ViewCount = 25
               },
               new AccommodationUnit
               {
                   Id = 5,
                   Title = "Villa Mostar",
                   AccommodationUnitCategoryId = 2,
                   Address = "Alice Rizikala, 8 I sprat, zgrada",
                   TownshipId = 55,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 4,
                   Price = 450,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "88af37ec-030c-45d4-9045-b941843e8c30_MostarThumb.jpg",
                   ViewCount = 3
               },
               new AccommodationUnit
               {
                   Id = 6,
                   Title = "Bungalovi Sarajevo",
                   AccommodationUnitCategoryId = 5,
                   Address = "Ferida Srnje 16",
                   TownshipId = 68,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 4,
                   Price = 300,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo.jpg",
                   ViewCount = 9
               },
               new AccommodationUnit
               {
                   Id = 7,
                   Title = "Apartman ROYAL Bulvear",
                   AccommodationUnitCategoryId = 2,
                   Address = "15 Fra Grge Martića",
                   TownshipId = 35,
                   Latitude = 43.856430,
                   Longitude = 18.413029,
                   OwnerId = 3,
                   Price = 250,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "bebefb25-41da-474b-8bcb-fdd291162409_RoyalThumb.jpg",
                   ViewCount = 15
               },
               new AccommodationUnit
               {
                   Id = 8,
                   Title = "Apartment Europe Sarajevo",
                   AccommodationUnitCategoryId = 3,
                   Address = "Vladislava Skarića 5",
                   TownshipId = 68,
                   Latitude = 43.8563,
                   Longitude = 18.4131,
                   OwnerId = 4,
                   Price = 200,
                   Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                   ThumbnailImage = "924B4AF0-91E3-4FDD-A248-77B9D9025F7C_VacationVibesThumb.jpg",
                   ViewCount = 12
               },
                new AccommodationUnit
                {
                    Id = 9,
                    Title = "Malak Regency Apartment",
                    AccommodationUnitCategoryId = 3,
                    Address = "Hrasnička cesta bb",
                    TownshipId = 67,
                    Latitude = 43.8563,
                    Longitude = 18.4131,
                    OwnerId = 1,
                    Price = 230,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak.jpg",
                   ViewCount = 13
                },
                new AccommodationUnit
                {
                    Id = 10,
                    Title = "Bungalovi Mostar",
                    AccommodationUnitCategoryId = 3,
                    Address = "Kneza Domagoja bb",
                    TownshipId = 65,
                    Latitude = 43.3438,
                    Longitude = 17.8078,
                    OwnerId = 1,
                    Price = 180,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar.jpg",
                   ViewCount = 20
                },
                new AccommodationUnit
                {
                    Id = 11,
                    Title = "Bristol",
                    AccommodationUnitCategoryId = 3,
                    Address = "Fra Filipa Lastrića 2",
                    TownshipId = 55,
                    Latitude = 43.8563,
                    Longitude = 18.4131,
                    OwnerId = 1,
                    Price = 220,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "F64F818A-51D1-4554-997E-B912BFB642D4_Bristol.jpg",
                   ViewCount = 19
                },
                new AccommodationUnit
                {
                    Id = 12,
                    Title = "Pino Nature",
                    AccommodationUnitCategoryId = 3,
                    Address = "Ravne 1",
                    TownshipId = 55,
                    Latitude = 43.8563,
                    Longitude = 18.4131,
                    OwnerId = 1,
                    Price = 250,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "AAD0545E-D5EA-41E8-AD27-692B07CEA75A_PinoNature.jpg",
                   ViewCount = 30
                },
                new AccommodationUnit
                {
                    Id = 13,
                    Title = "Villa Park Doboj",
                    AccommodationUnitCategoryId = 1,
                    Address = "Cara Dušana 10",
                    TownshipId = 87,
                    Latitude = 44.7333,
                    Longitude = 18.0833,
                    OwnerId = 3,
                    Price = 160,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj.jpg",
                   ViewCount = 1
                },
                new AccommodationUnit
                {
                    Id = 14,
                    Title = "Blanca Resort & Spa",
                    AccommodationUnitCategoryId = 3,
                    Address = "Babanovac Bb",
                    TownshipId = 55,
                    Latitude = 44.3115,
                    Longitude = 17.5950,
                    OwnerId = 4,
                    Price = 280,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca.jpg",
                   ViewCount = 10
                },
                new AccommodationUnit
                {
                    Id = 15,
                    Title = "Villa Mogorjelo",
                    AccommodationUnitCategoryId = 1,
                    Address = "Kralja Tomislava bb",
                    TownshipId = 52,
                    Latitude = 43.1216,
                    Longitude = 17.6841,
                    OwnerId = 4,
                    Price = 140,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo.jpg",
                   ViewCount = 3
                },
                new AccommodationUnit
                {
                    Id = 16,
                    Title = "Apartman Platani",
                    AccommodationUnitCategoryId = 2,
                    Address = "Cvijetni trg 1",
                    TownshipId = 81,
                    Latitude = 42.7086,
                    Longitude = 18.3283,
                    OwnerId = 1,
                    Price = 190,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "f860fff9-e427-4c4f-aade-871b1a7f684a_Platan.jpg",
                   ViewCount = 19
                },
                new AccommodationUnit
                {
                    Id = 17,
                    Title = "Nar Mostar",
                    AccommodationUnitCategoryId = 2,
                    Address = "Lacina 9a",
                    TownshipId = 55,
                    Latitude = 43.3438,
                    Longitude = 17.8078,
                    OwnerId = 1,
                    Price = 150,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar.jpg",
                    ViewCount = 21
                },
                new AccommodationUnit
                {
                    Id = 18,
                    Title = "Villa Park",
                    AccommodationUnitCategoryId = 1,
                    Address = "Lacina bb",
                    TownshipId = 71,
                    Latitude = 43.3438,
                    Longitude = 17.8078,
                    OwnerId = 1,
                    Price = 170,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "dfca9935-bc56-4218-ae2e-d472d2227526_Park.jpg",
                    ViewCount = 17
                },
                new AccommodationUnit
                {
                    Id = 19,
                    Title = "Apartman Kenan",
                    AccommodationUnitCategoryId = 2,
                    Address = "Kameni Spavač bb",
                    TownshipId = 12,
                    Latitude = 44.2036,
                    Longitude = 17.9073,
                    OwnerId = 3,
                    Price = 200,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "e6031584-3134-4580-9bd7-ead07fba6740_Kenan.jpg",
                    ViewCount = 21
                },
                new AccommodationUnit
                {
                    Id = 20,
                    Title = "Hotel Snježna Kuća",
                    AccommodationUnitCategoryId = 1,
                    Address = "Ski Resort, Mostar",
                    TownshipId = 40,
                    Latitude = 43.3438,
                    Longitude = 17.8078,
                    OwnerId = 3,
                    Price = 240,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "55250ffc-4450-4dc4-b5e3-a62ce5cb2bc3_Snjezna.jpg",
                    ViewCount = 4
                },
                new AccommodationUnit
                {
                    Id = 21,
                    Title = "Medjugorje Apartman",
                    AccommodationUnitCategoryId = 3,
                    Address = "Ulica fra Slavka Barbarića",
                    TownshipId = 48,
                    Latitude = 43.1864,
                    Longitude = 17.6791,
                    OwnerId = 4,
                    Price = 210,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje.jpg",
                    ViewCount = 2
                },
                new AccommodationUnit
                {
                    Id = 22,
                    Title = "Villa Blagaj",
                    AccommodationUnitCategoryId = 1,
                    Address = "Blagaj Bb",
                    TownshipId = 55,
                    Latitude = 43.2551,
                    Longitude = 17.8864,
                    OwnerId = 4,
                    Price = 160,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj.jpg",
                    ViewCount = 33
                },
                new AccommodationUnit
                {
                    Id = 23,
                    Title = "Hercegovina",
                    AccommodationUnitCategoryId = 3,
                    Address = "Brijesce bb",
                    TownshipId = 65,
                    Latitude = 43.8563,
                    Longitude = 18.4131,
                    OwnerId = 1,
                    Price = 250,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "9e726f37-6721-418c-b7da-5a8e80e1651c_Hercegovina.jpg",
                    ViewCount = 25
                },
                new AccommodationUnit
                {
                    Id = 24,
                    Title = "Villa Konjic",
                    AccommodationUnitCategoryId = 1,
                    Address = "Trg Državnosti bb",
                    TownshipId = 54,
                    Latitude = 43.6545,
                    Longitude = 17.9627,
                    OwnerId = 3,
                    Price = 150,
                    Status = Core.Domain.Enums.AccommodationUnitStatus.Active,
                    ThumbnailImage = "e4df6297-a151-413a-8241-c480fb27e289_Konjic.jpg",
                    ViewCount = 17
                }
           );

            #endregion

            #region AccommodationUnitPolicies
            modelBuilder.Entity<AccommodationUnit>().OwnsOne(x => x.AccommodationUnitPolicy).HasData(
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 1,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 6,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 2,
                    AlcoholAllowed = true,
                    BirthdayPartiesAllowed = true,
                    Capacity = 5,
                    HasPool = true,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 3,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 4,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 5,
                    HasPool = true,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 5,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 6,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = false,
                    Capacity = 6,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 7,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = true,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 8,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 9,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = true,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 10,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = true,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 11,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 12,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 13,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 14,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 15,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 16,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 17,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 18,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 19,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 20,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 21,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 22,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 23,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                },
                new AccommodationUnitPolicy
                {
                    AccommodationUnitId = 24,
                    AlcoholAllowed = false,
                    BirthdayPartiesAllowed = true,
                    Capacity = 10,
                    HasPool = false,
                    OneNightOnly = false,
                }
                );
            #endregion

            #region Reservations
            modelBuilder.Entity<Reservation>().HasData(
                new Reservation
                {
                    Id = 1,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 5, 6),
                    To = new DateTime(2024, 5, 11),
                    Code = "1/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 2,
                    TotalPrice = 750,
                },
                new Reservation
                {
                    Id = 2,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 3, 3),
                    To = new DateTime(2024, 3, 15),
                    Code = "2/2024",
                    NumberOfAdults = 4,
                    NumberOfChildren = 2,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 5,
                    TotalPrice = 2400,
                },
                new Reservation
                {
                    Id = 3,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 4, 5),
                    To = new DateTime(2024, 4, 16),
                    Code = "3/2024",
                    NumberOfAdults = 3,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 11,
                    TotalPrice = 2400,
                },
                new Reservation
                {
                    Id = 4,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 4, 21),
                    To = new DateTime(2024, 4, 25),
                    Code = "28/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 2,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 15,
                    TotalPrice = 600,
                },
                new Reservation
                {
                    Id = 5,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 4, 29),
                    To = new DateTime(2024, 4, 30),
                    Code = "29/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 15,
                    TotalPrice = 300,
                },
                new Reservation
                {
                    Id = 6,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 4, 29),
                    To = new DateTime(2024, 4, 30),
                    Code = "24/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 15,
                    TotalPrice = 300,
                },
                new Reservation
                {
                    Id = 7,
                    AccommodationUnitId = 2,
                    From = new DateTime(2024, 2, 15),
                    To = new DateTime(2024, 2, 20),
                    Code = "7/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 5,
                    TotalPrice = 500,
                },
                new Reservation
                {
                    Id = 8,
                    AccommodationUnitId = 3,
                    From = new DateTime(2024, 3, 5),
                    To = new DateTime(2024, 3, 10),
                    Code = "8/2024",
                    NumberOfAdults = 1,
                    NumberOfChildren = 2,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Confirmed,
                    UserId = 6,
                    TotalPrice = 450,
                },
                new Reservation
                {
                    Id = 9,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 4, 2),
                    To = new DateTime(2024, 4, 6),
                    Code = "9/2024",
                    NumberOfAdults = 3,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.InProgress,
                    UserId = 7,
                    TotalPrice = 600,
                },
                new Reservation
                {
                    Id = 10,
                    AccommodationUnitId = 4,
                    From = new DateTime(2024, 5, 10),
                    To = new DateTime(2024, 5, 15),
                    Code = "10/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 8,
                    TotalPrice = 520,
                },
                new Reservation
                {
                    Id = 11,
                    AccommodationUnitId = 5,
                    From = new DateTime(2024, 6, 1),
                    To = new DateTime(2024, 6, 3),
                    Code = "11/2024",
                    NumberOfAdults = 4,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Confirmed,
                    UserId = 9,
                    TotalPrice = 700,
                },
                new Reservation
                {
                    Id = 12,
                    AccommodationUnitId = 6,
                    From = new DateTime(2024, 7, 20),
                    To = new DateTime(2024, 7, 25),
                    Code = "12/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Confirmed,
                    UserId = 10,
                    TotalPrice = 480,
                },
                new Reservation
                {
                    Id = 13,
                    AccommodationUnitId = 7,
                    From = new DateTime(2024, 8, 15),
                    To = new DateTime(2024, 8, 17),
                    Code = "13/2024",
                    NumberOfAdults = 3,
                    NumberOfChildren = 2,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 11,
                    TotalPrice = 620,
                },
                new Reservation
                {
                    Id = 14,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 9, 10),
                    To = new DateTime(2024, 9, 12),
                    Code = "14/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Confirmed,
                    UserId = 12,
                    TotalPrice = 520,
                },
                new Reservation
                {
                    Id = 15,
                    AccommodationUnitId = 2,
                    From = new DateTime(2024, 10, 20),
                    To = new DateTime(2024, 10, 25),
                    Code = "15/2024",
                    NumberOfAdults = 4,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 13,
                    TotalPrice = 750,
                },
                new Reservation
                {
                    Id = 16,
                    AccommodationUnitId = 3,
                    From = new DateTime(2024, 11, 5),
                    To = new DateTime(2024, 11, 7),
                    Code = "16/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Draft,
                    UserId = 14,
                    TotalPrice = 320,
                },
                new Reservation
                {
                    Id = 17,
                    AccommodationUnitId = 4,
                    From = new DateTime(2024, 11, 10),
                    To = new DateTime(2024, 11, 12),
                    Code = "17/2024",
                    NumberOfAdults = 1,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Draft,
                    UserId = 5,
                    TotalPrice = 250,
                },
                new Reservation
                {
                    Id = 18,
                    AccommodationUnitId = 5,
                    From = new DateTime(2024, 11, 20),
                    To = new DateTime(2024, 11, 22),
                    Code = "18/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Draft,
                    UserId = 6,
                    TotalPrice = 300,
                },
                new Reservation
                {
                    Id = 19,
                    AccommodationUnitId = 6,
                    From = new DateTime(2024, 11, 25),
                    To = new DateTime(2024, 11, 28),
                    Code = "19/2024",
                    NumberOfAdults = 3,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Draft,
                    UserId = 7,
                    TotalPrice = 400,
                },
                new Reservation
                {
                    Id = 20,
                    AccommodationUnitId = 7,
                    From = new DateTime(2024, 12, 1),
                    To = new DateTime(2024, 12, 3),
                    Code = "20/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 0,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Confirmed,
                    UserId = 8,
                    TotalPrice = 380,
                },
                new Reservation
                {
                    Id = 21,
                    AccommodationUnitId = 1,
                    From = new DateTime(2024, 3, 18),
                    To = new DateTime(2024, 3, 20),
                    Code = "21/2024",
                    NumberOfAdults = 2,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.Completed,
                    UserId = 9,
                    TotalPrice = 340,
                },
                new Reservation
                {
                    Id = 22,
                    AccommodationUnitId = 2,
                    From = new DateTime(2024, 4, 25),
                    To = new DateTime(2024, 4, 28),
                    Code = "22/2024",
                    NumberOfAdults = 1,
                    NumberOfChildren = 2,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Card,
                    Status = Core.Domain.Enums.ReservationStatus.Confirmed,
                    UserId = 10,
                    TotalPrice = 410,
                },
                new Reservation
                {
                    Id = 23,
                    AccommodationUnitId = 3,
                    From = new DateTime(2024, 5, 6),
                    To = new DateTime(2024, 5, 8),
                    Code = "23/2024",
                    NumberOfAdults = 3,
                    NumberOfChildren = 1,
                    PaymentMethod = Core.Domain.Enums.PaymentMethod.Cash,
                    Status = Core.Domain.Enums.ReservationStatus.InProgress,
                    UserId = 11,
                    TotalPrice = 530,
                }

                );
            #endregion

            #region Images
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id = 1,
                    AccommodationUnitId = 1,
                    FileName = "0befdb86-650f-430d-814e-76d6a220a70e_VistaSarajevo1.jpg",
                },
                new Image
                {
                    Id = 2,
                    AccommodationUnitId = 1,
                    FileName = "3d768381-62a7-4cf7-bb2d-5d7a2cb9130f_VistaSarajevo2.jpg",
                },
                new Image
                {
                    Id = 3,
                    AccommodationUnitId = 1,
                    FileName = "4f458512-3235-4f25-9fc4-c31c3659869c_VistaSarajevo3.jpg",
                },
                new Image
                {
                    Id = 4,
                    AccommodationUnitId = 2,
                    FileName = "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove1.jpg",
                },
                new Image
                {
                    Id = 5,
                    AccommodationUnitId = 2,
                    FileName = "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove2.jpg"
                },
                new Image
                {
                    Id = 6,
                    AccommodationUnitId = 2,
                    FileName = "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove3.jpg"
                },
                new Image
                {
                    Id = 7,
                    AccommodationUnitId = 3,
                    FileName = "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta1.jpg"
                },
                new Image
                {
                    Id = 8,
                    AccommodationUnitId = 3,
                    FileName = "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta2.jpg"
                },
                new Image
                {
                    Id = 9,
                    AccommodationUnitId = 3,
                    FileName = "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta3.jpg"
                },
                new Image
                {
                    Id = 10,
                    AccommodationUnitId = 4,
                    FileName = "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen1.jpg"
                },
                new Image
                {
                    Id = 11,
                    AccommodationUnitId = 4,
                    FileName = "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen2.jpg"
                },
                new Image
                {
                    Id = 12,
                    AccommodationUnitId = 4,
                    FileName = "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen3.jpg"
                },
                new Image
                {
                    Id = 13,
                    AccommodationUnitId = 5,
                    FileName = "88af37ec-030c-45d4-9045-b941843e8c30_Mostar1.jpg"
                },
                new Image
                {
                    Id = 14,
                    AccommodationUnitId = 5,
                    FileName = "88af37ec-030c-45d4-9045-b941843e8c30_Mostar2.jpg"
                },
                new Image
                {
                    Id = 15,
                    AccommodationUnitId = 5,
                    FileName = "88af37ec-030c-45d4-9045-b941843e8c30_Mostar3.jpg"
                },
                new Image
                {
                    Id = 16,
                    AccommodationUnitId = 6,
                    FileName = "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo1.jpg"
                },
                new Image
                {
                    Id = 17,
                    AccommodationUnitId = 6,
                    FileName = "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo2.jpg"
                },
                new Image
                {
                    Id = 18,
                    AccommodationUnitId = 6,
                    FileName = "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo3.jpg"
                },
                new Image
                {
                    Id = 19,
                    AccommodationUnitId = 7,
                    FileName = "bebefb25-41da-474b-8bcb-fdd291162409_Royal1.jpg"
                },
                new Image
                {
                    Id = 20,
                    AccommodationUnitId = 7,
                    FileName = "bebefb25-41da-474b-8bcb-fdd291162409_Royal2.jpg"
                },
                new Image
                {
                    Id = 21,
                    AccommodationUnitId = 7,
                    FileName = "bebefb25-41da-474b-8bcb-fdd291162409_Royal3.jpg"
                },
                new Image
                {
                    Id = 22,
                    AccommodationUnitId = 8,
                    FileName = "924B4AF0-91E3-4FDD-A248-77B9D9025F7C_VacationVibes1.jpg"
                },
                new Image
                {
                    Id = 23,
                    AccommodationUnitId = 8,
                    FileName = "924B4AF0-91E3-4FDD-A248-77B9D9025F7C_VacationVibes2.jpg"
                },
                new Image
                {
                    Id = 24,
                    AccommodationUnitId = 9,
                    FileName = "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak1.jpg"
                },
                new Image
                {
                    Id = 25,
                    AccommodationUnitId = 9,
                    FileName = "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak2.jpg"
                },
                new Image
                {
                    Id = 26,
                    AccommodationUnitId = 9,
                    FileName = "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak3.jpg"
                },
                new Image
                {
                    Id = 27,
                    AccommodationUnitId = 10,
                    FileName = "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar1.jpg"
                },
                new Image
                {
                    Id = 28,
                    AccommodationUnitId = 10,
                    FileName = "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar2.jpg"
                },
                new Image
                {
                    Id = 29,
                    AccommodationUnitId = 10,
                    FileName = "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar3.jpg"
                },
                new Image
                {
                    Id = 30,
                    AccommodationUnitId = 11,
                    FileName = "F64F818A-51D1-4554-997E-B912BFB642D4_Bristol1.jpg"
                },
                new Image
                {
                    Id = 31,
                    AccommodationUnitId = 11,
                    FileName = "F64F818A-51D1-4554-997E-B912BFB642D4_Bristol2.jpg"
                },
                new Image
                {
                    Id = 32,
                    AccommodationUnitId = 12,
                    FileName = "AAD0545E-D5EA-41E8-AD27-692B07CEA75A_PinoNature1.jpg"
                },
                new Image
                {
                    Id = 33,
                    AccommodationUnitId = 12,
                    FileName = "AAD0545E-D5EA-41E8-AD27-692B07CEA75A_PinoNature2.jpg"
                },
                new Image
                {
                    Id = 34,
                    AccommodationUnitId = 13,
                    FileName = "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj1.jpg"
                },
                new Image
                {
                    Id = 35,
                    AccommodationUnitId = 13,
                    FileName = "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj2.jpg"
                },
                new Image
                {
                    Id = 36,
                    AccommodationUnitId = 13,
                    FileName = "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj3.jpg"
                },
                new Image
                {
                    Id = 37,
                    AccommodationUnitId = 14,
                    FileName = "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca1.jpg"
                },
                new Image
                {
                    Id = 38,
                    AccommodationUnitId = 14,
                    FileName = "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca2.jpg"
                },
                new Image
                {
                    Id = 68,
                    AccommodationUnitId = 14,
                    FileName = "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca3.jpg"
                },
                new Image
                {
                    Id = 39,
                    AccommodationUnitId = 15,
                    FileName = "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo1.jpg"
                },
                new Image
                {
                    Id = 40,
                    AccommodationUnitId = 15,
                    FileName = "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo2.jpg"
                },
                new Image
                {
                    Id = 41,
                    AccommodationUnitId = 15,
                    FileName = "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo3.jpg"
                },
                new Image
                {
                    Id = 42,
                    AccommodationUnitId = 16,
                    FileName = "f860fff9-e427-4c4f-aade-871b1a7f684a_Platan1.jpg"
                },
                new Image
                {
                    Id = 43,
                    AccommodationUnitId = 16,
                    FileName = "f860fff9-e427-4c4f-aade-871b1a7f684a_Platan2.jpg"
                },
                new Image
                {
                    Id = 44,
                    AccommodationUnitId = 17,
                    FileName = "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar1.jpg"
                },
                new Image
                {
                    Id = 45,
                    AccommodationUnitId = 17,
                    FileName = "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar2.jpg"
                },
                new Image
                {
                    Id = 47,
                    AccommodationUnitId = 17,
                    FileName = "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar3.jpg"
                },
                new Image
                {
                    Id = 48,
                    AccommodationUnitId = 18,
                    FileName = "dfca9935-bc56-4218-ae2e-d472d2227526_Park1.jpg"
                },
                new Image
                {
                    Id = 49,
                    AccommodationUnitId = 18,
                    FileName = "dfca9935-bc56-4218-ae2e-d472d2227526_Park2.jpg"
                },
                new Image
                {
                    Id = 50,
                    AccommodationUnitId = 19,
                    FileName = "e6031584-3134-4580-9bd7-ead07fba6740_Kenan1.jpg"
                },
                new Image
                {
                    Id = 51,
                    AccommodationUnitId = 19,
                    FileName = "e6031584-3134-4580-9bd7-ead07fba6740_Kenan2.jpg"
                },
                new Image
                {
                    Id = 52,
                    AccommodationUnitId = 19,
                    FileName = "e6031584-3134-4580-9bd7-ead07fba6740_Kenan3.jpg"
                },
                new Image
                {
                    Id = 53,
                    AccommodationUnitId = 20,
                    FileName = "55250ffc-4450-4dc4-b5e3-a62ce5cb2bc3_Snjezna1.jpg"
                },
                new Image
                {
                    Id = 54,
                    AccommodationUnitId = 20,
                    FileName = "55250ffc-4450-4dc4-b5e3-a62ce5cb2bc3_Snjezna2.jpg"
                },
                new Image
                {
                    Id = 55,
                    AccommodationUnitId = 21,
                    FileName = "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje1.jpg"
                },
                new Image
                {
                    Id = 56,
                    AccommodationUnitId = 21,
                    FileName = "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje2.jpg"
                },
                new Image
                {
                    Id = 57,
                    AccommodationUnitId = 21,
                    FileName = "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje3.jpg"
                },
                new Image
                {
                    Id = 58,
                    AccommodationUnitId = 21,
                    FileName = "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje4.jpg"
                },
                new Image
                {
                    Id = 59,
                    AccommodationUnitId = 22,
                    FileName = "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj1.jpg"
                },
                new Image
                {
                    Id = 60,
                    AccommodationUnitId = 22,
                    FileName = "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj2.jpg"
                },
                new Image
                {
                    Id = 61,
                    AccommodationUnitId = 22,
                    FileName = "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj3.jpg"
                },
                new Image
                {
                    Id = 62,
                    AccommodationUnitId = 23,
                    FileName = "9e726f37-6721-418c-b7da-5a8e80e1651c_Hercegovina1.jpg"
                },
                new Image
                {
                    Id = 63,
                    AccommodationUnitId = 23,
                    FileName = "9e726f37-6721-418c-b7da-5a8e80e1651c_Hercegovina2.jpg"
                },
                new Image
                {
                    Id = 64,
                    AccommodationUnitId = 24,
                    FileName = "e4df6297-a151-413a-8241-c480fb27e289_Konjic1.jpg"
                },
                new Image
                {
                    Id = 65,
                    AccommodationUnitId = 24,
                    FileName = "e4df6297-a151-413a-8241-c480fb27e289_Konjic2.jpg"
                },
                new Image
                {
                    Id = 66,
                    AccommodationUnitId = 24,
                    FileName = "e4df6297-a151-413a-8241-c480fb27e289_Konjic3.jpg"
                },
                new Image
                {
                    Id = 67,
                    AccommodationUnitId = 24,
                    FileName = "e4df6297-a151-413a-8241-c480fb27e289_Konjic4.jpg"
                }
                );

            #endregion

        }
    }
}
