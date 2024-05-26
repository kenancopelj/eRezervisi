using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class SetMultiPrimaryKeys : Migration
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

            migrationBuilder.DropPrimaryKey(
                name: "pk_guest_reviews",
                table: "guest_reviews");

            migrationBuilder.DropIndex(
                name: "ix_guest_reviews_guest_id",
                table: "guest_reviews");

            migrationBuilder.DropPrimaryKey(
                name: "pk_accommodation_unit_reviews",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropIndex(
                name: "ix_accommodation_unit_reviews_review_id",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "id",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "created_at",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "created_by",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "deleted",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "deleted_at",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "deleted_by",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "modified_at",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "modified_by",
                table: "guest_reviews");

            migrationBuilder.DropColumn(
                name: "id",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "created_at",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "created_by",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "deleted",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "deleted_at",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "deleted_by",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "modified_at",
                table: "accommodation_unit_reviews");

            migrationBuilder.DropColumn(
                name: "modified_by",
                table: "accommodation_unit_reviews");

            migrationBuilder.AlterColumn<DateTime>(
                name: "modified_at",
                table: "roles",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()",
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AlterColumn<bool>(
                name: "deleted",
                table: "roles",
                type: "bit",
                nullable: false,
                defaultValue: false,
                oldClrType: typeof(bool),
                oldType: "bit");

            migrationBuilder.AlterColumn<DateTime>(
                name: "created_at",
                table: "roles",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()",
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AddPrimaryKey(
                name: "pk_guest_reviews",
                table: "guest_reviews",
                columns: new[] { "guest_id", "review_id" });

            migrationBuilder.AddPrimaryKey(
                name: "pk_accommodation_unit_reviews",
                table: "accommodation_unit_reviews",
                columns: new[] { "review_id", "accommodation_unit_id" });

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

            migrationBuilder.DropPrimaryKey(
                name: "pk_guest_reviews",
                table: "guest_reviews");

            migrationBuilder.DropPrimaryKey(
                name: "pk_accommodation_unit_reviews",
                table: "accommodation_unit_reviews");

            migrationBuilder.AlterColumn<DateTime>(
                name: "modified_at",
                table: "roles",
                type: "datetime2",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValueSql: "GETUTCDATE()");

            migrationBuilder.AlterColumn<bool>(
                name: "deleted",
                table: "roles",
                type: "bit",
                nullable: false,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValue: false);

            migrationBuilder.AlterColumn<DateTime>(
                name: "created_at",
                table: "roles",
                type: "datetime2",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValueSql: "GETUTCDATE()");

            migrationBuilder.AddColumn<long>(
                name: "id",
                table: "guest_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddColumn<DateTime>(
                name: "created_at",
                table: "guest_reviews",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()");

            migrationBuilder.AddColumn<long>(
                name: "created_by",
                table: "guest_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<bool>(
                name: "deleted",
                table: "guest_reviews",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "deleted_at",
                table: "guest_reviews",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "deleted_by",
                table: "guest_reviews",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "modified_at",
                table: "guest_reviews",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()");

            migrationBuilder.AddColumn<long>(
                name: "modified_by",
                table: "guest_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<long>(
                name: "id",
                table: "accommodation_unit_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddColumn<DateTime>(
                name: "created_at",
                table: "accommodation_unit_reviews",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()");

            migrationBuilder.AddColumn<long>(
                name: "created_by",
                table: "accommodation_unit_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddColumn<bool>(
                name: "deleted",
                table: "accommodation_unit_reviews",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "deleted_at",
                table: "accommodation_unit_reviews",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "deleted_by",
                table: "accommodation_unit_reviews",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "modified_at",
                table: "accommodation_unit_reviews",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()");

            migrationBuilder.AddColumn<long>(
                name: "modified_by",
                table: "accommodation_unit_reviews",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);

            migrationBuilder.AddPrimaryKey(
                name: "pk_guest_reviews",
                table: "guest_reviews",
                column: "id");

            migrationBuilder.AddPrimaryKey(
                name: "pk_accommodation_unit_reviews",
                table: "accommodation_unit_reviews",
                column: "id");

            migrationBuilder.CreateIndex(
                name: "ix_guest_reviews_guest_id",
                table: "guest_reviews",
                column: "guest_id");

            migrationBuilder.CreateIndex(
                name: "ix_accommodation_unit_reviews_review_id",
                table: "accommodation_unit_reviews",
                column: "review_id");

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
