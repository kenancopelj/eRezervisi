using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class Initial_2 : Migration
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

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "users");

            migrationBuilder.DropColumn(
                name: "user_settings_id",
                table: "users");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "townships");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "texts");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "roles");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "reviews");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "reservations");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "notifications");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "irregularites");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "images");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "favorite_accommodation_units");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "cantons");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "accommodation_units");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "created_by_id",
                table: "accommodation_unit_categories");

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

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "users",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "user_settings_id",
                table: "users",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "townships",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "texts",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "roles",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "reservations",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "notifications",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "irregularites",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "images",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "guest_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "favorite_accommodation_units",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "cantons",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "accommodation_units",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "accommodation_unit_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "created_by_id",
                table: "accommodation_unit_categories",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

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
