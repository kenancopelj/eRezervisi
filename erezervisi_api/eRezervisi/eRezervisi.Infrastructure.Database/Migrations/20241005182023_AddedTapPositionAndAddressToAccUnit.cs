using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddedTapPositionAndAddressToAccUnit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "address",
                table: "accommodation_units",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<double>(
                name: "tap_position",
                table: "accommodation_units",
                type: "float",
                nullable: false,
                defaultValue: 0.0);

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 10, 5, 20, 20, 23, 277, DateTimeKind.Local).AddTicks(2162), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355" });

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 10, 5, 20, 20, 23, 277, DateTimeKind.Local).AddTicks(2208), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "address",
                table: "accommodation_units");

            migrationBuilder.DropColumn(
                name: "tap_position",
                table: "accommodation_units");

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 8, 29, 11, 32, 51, 665, DateTimeKind.Local).AddTicks(4039), "e38fa1a920da144b4f91c910b3e8f432c1cd3a6dd27f40a8bad40317e25981cf", "a45e7aa02fd2414eb66c0c24562205ba" });

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 8, 29, 11, 32, 51, 665, DateTimeKind.Local).AddTicks(4090), "e38fa1a920da144b4f91c910b3e8f432c1cd3a6dd27f40a8bad40317e25981cf", "a45e7aa02fd2414eb66c0c24562205ba" });
        }
    }
}
