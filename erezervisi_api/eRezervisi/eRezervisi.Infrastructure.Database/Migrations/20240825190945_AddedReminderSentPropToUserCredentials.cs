using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddedReminderSentPropToUserCredentials : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "reminder_sent",
                table: "user_credentials",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 25, 21, 9, 44, 567, DateTimeKind.Local).AddTicks(1784));

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 25, 21, 9, 44, 567, DateTimeKind.Local).AddTicks(1847));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "reminder_sent",
                table: "user_credentials");

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 22, 14, 6, 10, 539, DateTimeKind.Utc).AddTicks(2274));

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 22, 14, 6, 10, 539, DateTimeKind.Utc).AddTicks(2279));
        }
    }
}
