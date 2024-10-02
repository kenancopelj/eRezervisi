using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddedNotificationType : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_accommodation_unit_reviews_accommodation_units_accommodation_unit_id1",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropIndex(
                name: "ix_accommodation_unit_reviews_accommodation_unit_id1",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "accommodation_unit_id1",
                table: "accommodation_unit_reviews");

            migrationBuilder.AddColumn<int>(
                name: "type",
                table: "notifications",
                type: "int",
                nullable: false,
                defaultValueSql: "3");

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 8, 21, 13, 50, 59, 350, DateTimeKind.Utc).AddTicks(5649), "e38fa1a920da144b4f91c910b3e8f432c1cd3a6dd27f40a8bad40317e25981cf", "a45e7aa02fd2414eb66c0c24562205ba" });

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 8, 21, 13, 50, 59, 350, DateTimeKind.Utc).AddTicks(5651), "e38fa1a920da144b4f91c910b3e8f432c1cd3a6dd27f40a8bad40317e25981cf", "a45e7aa02fd2414eb66c0c24562205ba" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "type",
                table: "notifications");

            migrationBuilder.AddColumn<long>(
                name: "accommodation_unit_id1",
                table: "accommodation_unit_reviews",
                type: "bigint",
                nullable: true);

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 1L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 6, 1, 14, 21, 42, 673, DateTimeKind.Utc).AddTicks(2145), "ecb252044b5ea0f679ee78ec1a12904739e2904d", "960e802d-556e-459d-8b6f-f82f9862af2e" });

            migrationBuilder.UpdateData(
                table: "user_credentials",
                keyColumn: "id",
                keyValue: 2L,
                columns: new[] { "last_password_change_at", "password_hash", "password_salt" },
                values: new object[] { new DateTime(2024, 6, 1, 14, 21, 42, 673, DateTimeKind.Utc).AddTicks(2151), "d5a46c7224810ce14a50ca129158f72ab583a4b0af3f3c577de3f96369f59c9b", "9c571753-452b-421d-ad07-174c95108262" });

            migrationBuilder.CreateIndex(
                name: "ix_accommodation_unit_reviews_accommodation_unit_id1",
                table: "accommodation_unit_reviews",
                column: "accommodation_unit_id1");

            migrationBuilder.AddForeignKey(
                name: "fk_accommodation_unit_reviews_accommodation_units_accommodation_unit_id1",
                table: "accommodation_unit_reviews",
                column: "accommodation_unit_id1",
                principalTable: "accommodation_units",
                principalColumn: "id");
        }
    }
}
