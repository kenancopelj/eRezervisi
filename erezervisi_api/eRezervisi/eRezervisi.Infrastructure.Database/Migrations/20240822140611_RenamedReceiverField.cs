using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class RenamedReceiverField : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_messages_users_reciever_id",
                table: "messages");

            migrationBuilder.RenameColumn(
                name: "reciever_id",
                table: "messages",
                newName: "receiver_id");

            migrationBuilder.RenameIndex(
                name: "ix_messages_reciever_id",
                table: "messages",
                newName: "ix_messages_receiver_id");

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

            migrationBuilder.AddForeignKey(
                name: "fk_messages_users_receiver_id",
                table: "messages",
                column: "receiver_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_messages_users_receiver_id",
                table: "messages");

            migrationBuilder.RenameColumn(
                name: "receiver_id",
                table: "messages",
                newName: "reciever_id");

            migrationBuilder.RenameIndex(
                name: "ix_messages_receiver_id",
                table: "messages",
                newName: "ix_messages_reciever_id");

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 21, 13, 50, 59, 350, DateTimeKind.Utc).AddTicks(5649));

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                column: "last_password_change_at",
                value: new DateTime(2024, 8, 21, 13, 50, 59, 350, DateTimeKind.Utc).AddTicks(5651));

            migrationBuilder.AddForeignKey(
                name: "fk_messages_users_reciever_id",
                table: "messages",
                column: "reciever_id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
