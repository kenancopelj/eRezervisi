using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddedAccommodationUnitIdToNotification : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<long>(
                name: "accommodation_unit_id",
                table: "notifications",
                type: "bigint",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 29, 11, 32, 51, 665, DateTimeKind.Local).AddTicks(4039));

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 29, 11, 32, 51, 665, DateTimeKind.Local).AddTicks(4090));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "accommodation_unit_id",
                table: "notifications");

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 29, 10, 26, 13, 655, DateTimeKind.Local).AddTicks(4381));

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 29, 10, 26, 13, 655, DateTimeKind.Local).AddTicks(4442));
        }
    }
}
