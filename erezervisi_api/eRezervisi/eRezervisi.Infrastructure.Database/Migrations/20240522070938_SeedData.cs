using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class SeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_accommodation_unit_policies_accommodation_units_id",
                table: "accommodation_unit_policies");

            migrationBuilder.DropForeignKey(
                name: "fk_user_credentials_users_id",
                table: "user_credentials");

            migrationBuilder.DropForeignKey(
                name: "fk_user_settings_users_id",
                table: "user_settings");

            migrationBuilder.InsertData(
                table: "roles",
                columns: new[] { "id", "created_at", "created_by", "deleted", "deleted_at", "deleted_by", "modified_at", "modified_by", "name" },
                values: new object[,]
                {
                    { 1L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, false, null, null, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, "Owner" },
                    { 2L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, false, null, null, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, "MobileUser" }
                });

            migrationBuilder.AddForeignKey(
                name: "fk_accommodation_unit_policies_accommodation_units_id",
                table: "accommodation_unit_policies",
                column: "id",
                principalTable: "accommodation_units",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_user_credentials_users_id",
                table: "user_credentials",
                column: "id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "fk_user_settings_users_id",
                table: "user_settings",
                column: "id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_accommodation_unit_policies_accommodation_units_id",
                table: "accommodation_unit_policies");

            migrationBuilder.DropForeignKey(
                name: "fk_user_credentials_users_id",
                table: "user_credentials");

            migrationBuilder.DropForeignKey(
                name: "fk_user_settings_users_id",
                table: "user_settings");

            migrationBuilder.DeleteData(
                table: "roles",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "roles",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.AddForeignKey(
                name: "fk_accommodation_unit_policies_accommodation_units_id",
                table: "accommodation_unit_policies",
                column: "id",
                principalTable: "accommodation_units",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_user_credentials_users_id",
                table: "user_credentials",
                column: "id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "fk_user_settings_users_id",
                table: "user_settings",
                column: "id",
                principalTable: "users",
                principalColumn: "id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
