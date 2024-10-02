using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddedReceiveNotificationsProp : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "send_reminder_at",
                table: "user_settings");

            migrationBuilder.RenameColumn(
                name: "recieve_emails",
                table: "user_settings",
                newName: "receive_notifications");

            migrationBuilder.AddColumn<bool>(
                name: "receive_emails",
                table: "user_settings",
                type: "bit",
                nullable: false,
                defaultValue: true);

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

            migrationBuilder.UpdateData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 1L,
                column: "receive_emails",
                value: true);

            migrationBuilder.UpdateData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 2L,
                column: "receive_emails",
                value: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "receive_emails",
                table: "user_settings");

            migrationBuilder.RenameColumn(
                name: "receive_notifications",
                table: "user_settings",
                newName: "recieve_emails");

            migrationBuilder.AddColumn<DateTime>(
                name: "send_reminder_at",
                table: "user_settings",
                type: "datetime2",
                nullable: true);

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

            migrationBuilder.UpdateData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 1L,
                column: "send_reminder_at",
                value: null);

            migrationBuilder.UpdateData(
                table: "user_settings",
                keyColumn: "id",
                keyValue: 2L,
                column: "send_reminder_at",
                value: null);
        }
    }
}
