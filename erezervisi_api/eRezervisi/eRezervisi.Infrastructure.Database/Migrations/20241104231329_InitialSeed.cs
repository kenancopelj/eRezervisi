using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class InitialSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_townships_post_code",
                table: "townships");

            migrationBuilder.DropColumn(
                name: "latitude",
                table: "townships");

            migrationBuilder.DropColumn(
                name: "longitude",
                table: "townships");

            migrationBuilder.DropColumn(
                name: "post_code",
                table: "townships");

            migrationBuilder.InsertData(
                table: "accommodation_unit_categories",
                columns: new[] { "id", "created_by", "deleted_at", "deleted_by", "modified_by", "short_title", "title" },
                values: new object[,]
                {
                    { 1L, 0L, null, null, 0L, "APT", "Apartmani" },
                    { 2L, 0L, null, null, 0L, "VIL", "Ville" },
                    { 3L, 0L, null, null, 0L, "VIK", "Vikendice" },
                    { 4L, 0L, null, null, 0L, "PRI", "Privatne kuće" },
                    { 5L, 0L, null, null, 0L, "BGL", "Bungalovi" }
                });

            migrationBuilder.InsertData(
                table: "cantons",
                columns: new[] { "id", "created_by", "deleted_at", "deleted_by", "modified_by", "short_title", "title" },
                values: new object[,]
                {
                    { 1L, 0L, null, null, 0L, "USK", "Unsko-sanski kanton" },
                    { 2L, 0L, null, null, 0L, "PK", "Posavski kanton" },
                    { 3L, 0L, null, null, 0L, "TK", "Tuzlanski kanton" },
                    { 4L, 0L, null, null, 0L, "ZDK", "Zeničko-dobojski kanton" },
                    { 5L, 0L, null, null, 0L, "BPK", "Bosansko-podrinjski kanton" },
                    { 6L, 0L, null, null, 0L, "SBK", "Srednjobosanski kanton" },
                    { 7L, 0L, null, null, 0L, "HNK", "Herecegovačko-neretvanski kanton" },
                    { 8L, 0L, null, null, 0L, "ZHK", "Zapadnohercegovački kanton" },
                    { 9L, 0L, null, null, 0L, "KS", "Kanton Sarajevo" },
                    { 10L, 0L, null, null, 0L, "K10", "Kanton 10" },
                    { 11L, 0L, null, null, 0L, "RS", "Republika Srpksa" }
                });

            migrationBuilder.InsertData(
                table: "roles",
                columns: new[] { "id", "created_by", "deleted_at", "deleted_by", "modified_by", "name" },
                values: new object[,]
                {
                    { 1L, 0L, null, null, 0L, "Owner" },
                    { 2L, 0L, null, null, 0L, "MobileUser" }
                });

            migrationBuilder.InsertData(
                table: "townships",
                columns: new[] { "id", "canton_id", "created_by", "deleted_at", "deleted_by", "modified_by", "title" },
                values: new object[,]
                {
                    { 1L, 1L, 0L, null, null, 0L, "Bihać" },
                    { 2L, 1L, 0L, null, null, 0L, "Bosanska Krupa" },
                    { 3L, 1L, 0L, null, null, 0L, "Bosanski Petrovac" },
                    { 4L, 1L, 0L, null, null, 0L, "Bužim" },
                    { 5L, 1L, 0L, null, null, 0L, "Cazin" },
                    { 6L, 1L, 0L, null, null, 0L, "Ključ" },
                    { 7L, 1L, 0L, null, null, 0L, "Sanski Most" },
                    { 8L, 1L, 0L, null, null, 0L, "Velika Kladuša" },
                    { 9L, 2L, 0L, null, null, 0L, "Domaljevac-Šamac" },
                    { 10L, 2L, 0L, null, null, 0L, "Odžak" },
                    { 11L, 2L, 0L, null, null, 0L, "Orašje" },
                    { 12L, 3L, 0L, null, null, 0L, "Banovići" },
                    { 13L, 3L, 0L, null, null, 0L, "Čelić" },
                    { 14L, 3L, 0L, null, null, 0L, "Doboj Istok" },
                    { 15L, 3L, 0L, null, null, 0L, "Gračanica" },
                    { 16L, 3L, 0L, null, null, 0L, "Gradačac" },
                    { 17L, 3L, 0L, null, null, 0L, "Kalesija" },
                    { 18L, 3L, 0L, null, null, 0L, "Kladanj" },
                    { 19L, 3L, 0L, null, null, 0L, "Lukavac" },
                    { 20L, 3L, 0L, null, null, 0L, "Sapna" },
                    { 21L, 3L, 0L, null, null, 0L, "Srebrenik" },
                    { 22L, 3L, 0L, null, null, 0L, "Teočak" },
                    { 23L, 3L, 0L, null, null, 0L, "Tuzla" },
                    { 24L, 3L, 0L, null, null, 0L, "Živinice" },
                    { 25L, 4L, 0L, null, null, 0L, "Breza" },
                    { 26L, 4L, 0L, null, null, 0L, "Doboj Jug" },
                    { 27L, 4L, 0L, null, null, 0L, "Kakanj" },
                    { 28L, 4L, 0L, null, null, 0L, "Maglaj" },
                    { 29L, 4L, 0L, null, null, 0L, "Olovo" },
                    { 30L, 4L, 0L, null, null, 0L, "Tešanj" },
                    { 31L, 4L, 0L, null, null, 0L, "Usora" },
                    { 32L, 4L, 0L, null, null, 0L, "Vareš" },
                    { 33L, 4L, 0L, null, null, 0L, "Visoko" },
                    { 34L, 4L, 0L, null, null, 0L, "Zavidovići" },
                    { 35L, 4L, 0L, null, null, 0L, "Zenica" },
                    { 36L, 4L, 0L, null, null, 0L, "Žepče" },
                    { 37L, 5L, 0L, null, null, 0L, "Foča" },
                    { 38L, 5L, 0L, null, null, 0L, "Goražde" },
                    { 39L, 5L, 0L, null, null, 0L, "Pale" },
                    { 40L, 6L, 0L, null, null, 0L, "Bugojno" },
                    { 41L, 6L, 0L, null, null, 0L, "Busovača" },
                    { 42L, 6L, 0L, null, null, 0L, "Dobretići" },
                    { 43L, 6L, 0L, null, null, 0L, "Donji Vakuf" },
                    { 44L, 6L, 0L, null, null, 0L, "Fojnica" },
                    { 45L, 6L, 0L, null, null, 0L, "Gornji Vakuf-Uskoplje" },
                    { 46L, 6L, 0L, null, null, 0L, "Jajce" },
                    { 47L, 6L, 0L, null, null, 0L, "Kiseljak" },
                    { 48L, 6L, 0L, null, null, 0L, "Kreševo" },
                    { 49L, 6L, 0L, null, null, 0L, "Novi Travnik" },
                    { 50L, 6L, 0L, null, null, 0L, "Travnik" },
                    { 51L, 6L, 0L, null, null, 0L, "Vitez" },
                    { 52L, 7L, 0L, null, null, 0L, "Čapljina" },
                    { 53L, 7L, 0L, null, null, 0L, "Jablanica" },
                    { 54L, 7L, 0L, null, null, 0L, "Konjic" },
                    { 55L, 7L, 0L, null, null, 0L, "Mostar" },
                    { 56L, 7L, 0L, null, null, 0L, "Neum" },
                    { 57L, 7L, 0L, null, null, 0L, "Prozor-Rama" },
                    { 58L, 7L, 0L, null, null, 0L, "Ravno" },
                    { 59L, 7L, 0L, null, null, 0L, "Stolac" },
                    { 60L, 8L, 0L, null, null, 0L, "Grude" },
                    { 61L, 8L, 0L, null, null, 0L, "Ljubuški" },
                    { 62L, 8L, 0L, null, null, 0L, "Posušje" },
                    { 63L, 8L, 0L, null, null, 0L, "Široki Brijeg" },
                    { 64L, 9L, 0L, null, null, 0L, "Centar" },
                    { 65L, 9L, 0L, null, null, 0L, "Novi Grad" },
                    { 66L, 9L, 0L, null, null, 0L, "Novo Sarajevo" },
                    { 67L, 9L, 0L, null, null, 0L, "Stari Grad" },
                    { 68L, 9L, 0L, null, null, 0L, "Sarajevo" },
                    { 69L, 9L, 0L, null, null, 0L, "Hadžići" },
                    { 70L, 9L, 0L, null, null, 0L, "Ilidža" },
                    { 71L, 9L, 0L, null, null, 0L, "Ilijaš" },
                    { 72L, 9L, 0L, null, null, 0L, "Trnovo" },
                    { 73L, 9L, 0L, null, null, 0L, "Vogošća" },
                    { 74L, 10L, 0L, null, null, 0L, "Bosansko Grahovo" },
                    { 75L, 10L, 0L, null, null, 0L, "Drvar" },
                    { 76L, 10L, 0L, null, null, 0L, "Glamoč" },
                    { 77L, 10L, 0L, null, null, 0L, "Kupres" },
                    { 78L, 10L, 0L, null, null, 0L, "Livno" },
                    { 79L, 10L, 0L, null, null, 0L, "Tomislavgrad" },
                    { 80L, 11L, 0L, null, null, 0L, "Banja Luka" },
                    { 81L, 11L, 0L, null, null, 0L, "Trebinje" },
                    { 82L, 11L, 0L, null, null, 0L, "Zvornik" },
                    { 83L, 11L, 0L, null, null, 0L, "Prijedor" },
                    { 84L, 11L, 0L, null, null, 0L, "Gradiška" },
                    { 85L, 11L, 0L, null, null, 0L, "Derventa" },
                    { 86L, 11L, 0L, null, null, 0L, "Bijeljina" },
                    { 87L, 11L, 0L, null, null, 0L, "Doboj" }
                });

            migrationBuilder.InsertData(
                table: "users",
                columns: new[] { "id", "address", "created_by", "deleted_at", "deleted_by", "email", "first_name", "image", "is_active", "last_name", "modified_by", "phone", "role_id" },
                values: new object[,]
                {
                    { 1L, "Opine b.b", 0L, null, null, "kenan.copelj@edu.fit.ba", "Owner", null, true, "User", 0L, "+387616161", 1L },
                    { 2L, "0000", 0L, null, null, "kenan.copelj@edu.fit.ba", "Regular", null, true, "User", 0L, "0000", 2L },
                    { 3L, "123 Main St", 0L, null, null, "emma.watson@domain.com", "Emma", null, true, "Watson", 0L, "+38761234501", 1L },
                    { 4L, "456 Elm St", 0L, null, null, "liam.johnson@domain.com", "Liam", null, true, "Johnson", 0L, "+38761234502", 1L },
                    { 5L, "789 Maple Ave", 0L, null, null, "olivia.brown@domain.com", "Olivia", null, true, "Brown", 0L, "+38761234503", 2L },
                    { 6L, "101 Oak Rd", 0L, null, null, "noah.williams@domain.com", "Noah", null, true, "Williams", 0L, "+38761234504", 2L },
                    { 7L, "202 Pine St", 0L, null, null, "ava.jones@domain.com", "Ava", null, true, "Jones", 0L, "+38761234505", 2L },
                    { 8L, "303 Cedar Ave", 0L, null, null, "mason.garcia@domain.com", "Mason", null, true, "Garcia", 0L, "+38761234506", 2L },
                    { 9L, "404 Birch Blvd", 0L, null, null, "sophia.martinez@domain.com", "Sophia", null, true, "Martinez", 0L, "+38761234507", 2L },
                    { 10L, "505 Willow Way", 0L, null, null, "lucas.anderson@domain.com", "Lucas", null, true, "Anderson", 0L, "+38761234508", 2L },
                    { 11L, "606 Chestnut St", 0L, null, null, "amelia.thomas@domain.com", "Amelia", null, true, "Thomas", 0L, "+38761234509", 2L },
                    { 12L, "707 Spruce Ave", 0L, null, null, "ethan.lee@domain.com", "Ethan", null, true, "Lee", 0L, "+38761234510", 2L },
                    { 13L, "808 Redwood Rd", 0L, null, null, "isabella.davis@domain.com", "Isabella", null, true, "Davis", 0L, "+38761234511", 2L },
                    { 14L, "909 Fir Ln", 0L, null, null, "logan.wilson@domain.com", "Logan", null, true, "Wilson", 0L, "+38761234512", 2L },
                    { 15L, "1010 Palm St", 0L, null, null, "mia.hernandez@domain.com", "Mia", null, true, "Hernandez", 0L, "+38761234513", 2L },
                    { 16L, "1111 Maplewood Dr", 0L, null, null, "james.robinson@domain.com", "James", null, true, "Robinson", 0L, "+38761234514", 2L },
                    { 17L, "1212 Pinewood Ln", 0L, null, null, "harper.clark@domain.com", "Harper", null, true, "Clark", 0L, "+38761234515", 2L }
                });

            migrationBuilder.InsertData(
                table: "accommodation_units",
                columns: new[] { "id", "accommodation_unit_category_id", "address", "created_by", "deactivate_at", "deleted_at", "deleted_by", "latitude", "longitude", "modified_by", "note", "owner_id", "price", "status", "thumbnail_image", "title", "township_id" },
                values: new object[,]
                {
                    { 1L, 1L, "Mula Mustafe Bašeskije", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 1L, 150.0, 1, "63f06b1f-f76e-45b7-82ed-0631381f85fc_VistaSarajevoThumb.jpg", "Central Vista Apartments Sarajevo", 66L },
                    { 2L, 2L, "Pehlivanuša 67", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 1L, 898.0, 1, "55899be7-94fe-40b8-84a0-b66b00b022c8_OneLoveThumb.jpg", "One Love", 68L },
                    { 3L, 1L, "Soldina 3", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 3L, 369.0, 1, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_CittaThumb.jpg", "Apartment Citta Vecchia", 55L },
                    { 4L, 2L, "II. bojne rudničke 185A", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 3L, 369.0, 1, "49f38bd6-1d31-4458-997d-b5739e5d7fda_FlumenThumb.jpg", "Villa Flumen", 55L },
                    { 5L, 2L, "Alice Rizikala, 8 I sprat, zgrada", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 4L, 450.0, 1, "88af37ec-030c-45d4-9045-b941843e8c30_MostarThumb.jpg", "Villa Mostar", 55L },
                    { 6L, 5L, "Ferida Srnje 16", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 4L, 300.0, 1, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo.jpg", "Bungalovi Sarajevo", 68L },
                    { 7L, 2L, "15 Fra Grge Martića", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 3L, 250.0, 1, "bebefb25-41da-474b-8bcb-fdd291162409_RoyalThumb.jpg", "Apartman ROYAL Bulvear", 35L },
                    { 8L, 3L, "Vladislava Skarića 5", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 4L, 200.0, 1, "", "Apartment Europe Sarajevo", 68L },
                    { 9L, 3L, "Hrasnička cesta bb", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 230.0, 1, "", "Malak Regency Apartment", 67L },
                    { 10L, 3L, "Kneza Domagoja bb", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 1L, 180.0, 1, "", "Bungalovi Mostar", 65L },
                    { 11L, 3L, "Fra Filipa Lastrića 2", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 220.0, 1, "", "Bristol", 55L },
                    { 12L, 3L, "Ravne 1", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 250.0, 1, "", "Pino Nature", 55L },
                    { 13L, 1L, "Cara Dušana 10", 0L, null, null, null, 44.7333, 18.083300000000001, 0L, null, 3L, 160.0, 1, "", "Villa Park Doboj", 87L },
                    { 14L, 3L, "Babanovac Bb", 0L, null, null, null, 44.311500000000002, 17.594999999999999, 0L, null, 4L, 280.0, 1, "", "Blanca Resort & Spa", 55L },
                    { 15L, 1L, "Kralja Tomislava bb", 0L, null, null, null, 43.121600000000001, 17.684100000000001, 0L, null, 4L, 140.0, 1, "", "Villa Mogorjelo", 52L },
                    { 16L, 2L, "Cvijetni trg 1", 0L, null, null, null, 42.708599999999997, 18.328299999999999, 0L, null, 1L, 190.0, 1, "", "Apartman Platani", 81L },
                    { 17L, 2L, "Lacina 9a", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 1L, 150.0, 1, "", "Nar Mostar", 55L },
                    { 18L, 1L, "Lacina bb", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 1L, 170.0, 1, "", "Villa Park", 71L },
                    { 19L, 2L, "Kameni Spavač bb", 0L, null, null, null, 44.203600000000002, 17.907299999999999, 0L, null, 3L, 200.0, 1, "", "Apartman Kenan", 12L },
                    { 20L, 1L, "Ski Resort, Mostar", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 3L, 240.0, 1, "", "Hotel Snježna Kuća", 40L },
                    { 21L, 3L, "Ulica fra Slavka Barbarića", 0L, null, null, null, 43.186399999999999, 17.679099999999998, 0L, null, 4L, 210.0, 1, "", "Medjugorje Hotel & Spa", 48L },
                    { 22L, 1L, "Blagaj Bb", 0L, null, null, null, 43.255099999999999, 17.886399999999998, 0L, null, 4L, 160.0, 1, "", "Villa Blagaj", 55L },
                    { 23L, 3L, "Brijesce bb", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 250.0, 1, "", "Hercegovina", 65L },
                    { 24L, 1L, "Trg Državnosti bb", 0L, null, null, null, 43.654499999999999, 17.962700000000002, 0L, null, 3L, 150.0, 1, "", "Villa Konjic", 54L }
                });

            migrationBuilder.InsertData(
                table: "user_credentials",
                columns: new[] { "id", "last_password_change_at", "password_hash", "password_salt", "refresh_token", "refresh_token_expires_at_utc", "username" },
                values: new object[,]
                {
                    { 1L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "desktop" },
                    { 2L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "mobile" },
                    { 3L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "emmawatson" },
                    { 4L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "liamjohnson" },
                    { 5L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "oliviabrown" },
                    { 6L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "noahwilliams" },
                    { 7L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "avajones" },
                    { 8L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "masongarcia" },
                    { 9L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "sophiamartinez" },
                    { 10L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "lucasanderson" },
                    { 11L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "ameliathomas" },
                    { 12L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "ethanlee" },
                    { 13L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "isabelladavis" },
                    { 14L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "loganwilson" },
                    { 15L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "miahernandez" },
                    { 16L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "jamesrobinson" },
                    { 17L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "harperclark" }
                });

            migrationBuilder.InsertData(
                table: "user_settings",
                columns: new[] { "id", "mark_object_as_unclean_after_reservation", "receive_emails", "receive_notifications" },
                values: new object[,]
                {
                    { 1L, false, true, true },
                    { 2L, false, true, true },
                    { 3L, false, true, true },
                    { 4L, false, true, true },
                    { 5L, false, true, true },
                    { 6L, false, true, true },
                    { 7L, false, true, true },
                    { 8L, false, true, true },
                    { 9L, false, true, true },
                    { 10L, false, true, true },
                    { 11L, false, true, true },
                    { 12L, false, true, true },
                    { 13L, false, true, true },
                    { 14L, false, true, true },
                    { 15L, false, true, true },
                    { 16L, false, true, true },
                    { 17L, false, true, true }
                });

            migrationBuilder.InsertData(
                table: "images",
                columns: new[] { "id", "accommodation_unit_id", "created_by", "deleted_at", "deleted_by", "file_name", "modified_by" },
                values: new object[,]
                {
                    { 1L, 1L, 0L, null, null, "0befdb86-650f-430d-814e-76d6a220a70e_VistaSarajevo1.jpg", 0L },
                    { 2L, 1L, 0L, null, null, "3d768381-62a7-4cf7-bb2d-5d7a2cb9130f_VistaSarajevo2.jpg", 0L },
                    { 3L, 1L, 0L, null, null, "4f458512-3235-4f25-9fc4-c31c3659869c_VistaSarajevo3.jpg", 0L },
                    { 4L, 2L, 0L, null, null, "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove1.jpg", 0L },
                    { 5L, 2L, 0L, null, null, "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove2.jpg", 0L },
                    { 6L, 2L, 0L, null, null, "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove3.jpg", 0L },
                    { 7L, 3L, 0L, null, null, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta1.jpg", 0L },
                    { 8L, 3L, 0L, null, null, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta2.jpg", 0L },
                    { 9L, 3L, 0L, null, null, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta3.jpg", 0L },
                    { 10L, 4L, 0L, null, null, "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen1.jpg", 0L },
                    { 11L, 4L, 0L, null, null, "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen2.jpg", 0L },
                    { 12L, 4L, 0L, null, null, "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen3.jpg", 0L },
                    { 13L, 5L, 0L, null, null, "88af37ec-030c-45d4-9045-b941843e8c30_Mostar1.jpg", 0L },
                    { 14L, 5L, 0L, null, null, "88af37ec-030c-45d4-9045-b941843e8c30_Mostar2.jpg", 0L },
                    { 15L, 5L, 0L, null, null, "88af37ec-030c-45d4-9045-b941843e8c30_Mostar3.jpg", 0L },
                    { 16L, 6L, 0L, null, null, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo1.jpg", 0L },
                    { 17L, 6L, 0L, null, null, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo2.jpg", 0L },
                    { 18L, 6L, 0L, null, null, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo3.jpg", 0L },
                    { 19L, 7L, 0L, null, null, "bebefb25-41da-474b-8bcb-fdd291162409_Royal1.jpg", 0L },
                    { 20L, 7L, 0L, null, null, "bebefb25-41da-474b-8bcb-fdd291162409_Royal2.jpg", 0L },
                    { 21L, 7L, 0L, null, null, "bebefb25-41da-474b-8bcb-fdd291162409_Royal3.jpg", 0L }
                });

            migrationBuilder.InsertData(
                table: "reservations",
                columns: new[] { "id", "accommodation_unit_id", "code", "created_by", "deleted_at", "deleted_by", "from", "modified_by", "note", "number_of_adults", "number_of_children", "payment_method", "status", "to", "total_price", "user_id" },
                values: new object[,]
                {
                    { 1L, 1L, "1/2024", 0L, null, null, new DateTime(2024, 5, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 2, 6, new DateTime(2024, 5, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 750.0, 2L },
                    { 2L, 1L, "2/2024", 0L, null, null, new DateTime(2024, 3, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 4, 2, 1, 6, new DateTime(2024, 3, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2400.0, 5L },
                    { 3L, 1L, "3/2024", 0L, null, null, new DateTime(2024, 4, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 1, 6, new DateTime(2024, 4, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 2400.0, 11L },
                    { 4L, 1L, "28/2024", 0L, null, null, new DateTime(2024, 4, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 2, 1, 6, new DateTime(2024, 4, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 600.0, 15L },
                    { 5L, 1L, "29/2024", 0L, null, null, new DateTime(2024, 4, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 6, new DateTime(2024, 4, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 300.0, 15L },
                    { 6L, 1L, "24/2024", 0L, null, null, new DateTime(2024, 4, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 6, new DateTime(2024, 4, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 300.0, 15L },
                    { 7L, 2L, "7/2024", 0L, null, null, new DateTime(2024, 2, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 2, 6, new DateTime(2024, 2, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 500.0, 5L },
                    { 8L, 3L, "8/2024", 0L, null, null, new DateTime(2024, 3, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 1, 2, 1, 2, new DateTime(2024, 3, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 450.0, 6L },
                    { 9L, 1L, "9/2024", 0L, null, null, new DateTime(2024, 4, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 2, 3, new DateTime(2024, 4, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 600.0, 7L },
                    { 10L, 4L, "10/2024", 0L, null, null, new DateTime(2024, 5, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 6, new DateTime(2024, 5, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 520.0, 8L },
                    { 11L, 5L, "11/2024", 0L, null, null, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 4, 0, 2, 2, new DateTime(2024, 6, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 700.0, 9L },
                    { 12L, 6L, "12/2024", 0L, null, null, new DateTime(2024, 7, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 2, new DateTime(2024, 7, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 480.0, 10L },
                    { 13L, 7L, "13/2024", 0L, null, null, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 2, 2, 6, new DateTime(2024, 8, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), 620.0, 11L },
                    { 14L, 1L, "14/2024", 0L, null, null, new DateTime(2024, 9, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 520.0, 12L },
                    { 15L, 2L, "15/2024", 0L, null, null, new DateTime(2024, 10, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 4, 0, 2, 6, new DateTime(2024, 10, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 750.0, 13L },
                    { 16L, 3L, "16/2024", 0L, null, null, new DateTime(2024, 11, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 1, new DateTime(2024, 11, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), 320.0, 14L },
                    { 17L, 4L, "17/2024", 0L, null, null, new DateTime(2024, 11, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 1, 0, 2, 1, new DateTime(2024, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 250.0, 5L },
                    { 18L, 5L, "18/2024", 0L, null, null, new DateTime(2024, 11, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 1, new DateTime(2024, 11, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), 300.0, 6L },
                    { 19L, 6L, "19/2024", 0L, null, null, new DateTime(2024, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 2, 1, new DateTime(2024, 11, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), 400.0, 7L },
                    { 20L, 7L, "20/2024", 0L, null, null, new DateTime(2024, 12, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 2, new DateTime(2024, 12, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 380.0, 8L },
                    { 21L, 1L, "21/2024", 0L, null, null, new DateTime(2024, 3, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 6, new DateTime(2024, 3, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 340.0, 9L },
                    { 22L, 2L, "22/2024", 0L, null, null, new DateTime(2024, 4, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 1, 2, 2, 2, new DateTime(2024, 4, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), 410.0, 10L },
                    { 23L, 3L, "23/2024", 0L, null, null, new DateTime(2024, 5, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 1, 3, new DateTime(2024, 5, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), 530.0, 11L }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "accommodation_unit_categories",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 18L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 19L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 20L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 21L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 22L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 23L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 24L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 18L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 19L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 20L);

            migrationBuilder.DeleteData(
                table: "images",
                keyColumn: "id",
                keyValue: 21L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 18L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 19L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 20L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 21L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 22L);

            migrationBuilder.DeleteData(
                table: "reservations",
                keyColumn: "id",
                keyValue: 23L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 18L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 19L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 20L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 21L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 22L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 23L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 24L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 25L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 26L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 27L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 28L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 29L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 30L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 31L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 32L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 33L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 34L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 36L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 37L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 38L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 39L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 41L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 42L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 43L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 44L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 45L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 46L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 47L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 49L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 50L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 51L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 53L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 56L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 57L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 58L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 59L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 60L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 61L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 62L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 63L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 64L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 69L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 70L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 72L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 73L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 74L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 75L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 76L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 77L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 78L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 79L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 80L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 82L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 83L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 84L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 85L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 86L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_categories",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 40L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 48L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 52L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 54L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 65L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 67L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 71L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 81L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 87L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_categories",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_categories",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_categories",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "roles",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 35L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 55L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 66L);

            migrationBuilder.DeleteData(
                table: "townships",
                keyColumn: "id",
                keyValue: 68L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "cantons",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "roles",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.AddColumn<double>(
                name: "latitude",
                table: "townships",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<double>(
                name: "longitude",
                table: "townships",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.AddColumn<string>(
                name: "post_code",
                table: "townships",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "ix_townships_post_code",
                table: "townships",
                column: "post_code");
        }
    }
}
