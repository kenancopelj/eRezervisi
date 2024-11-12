using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class test : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "accommodation_unit_policies",
                columns: new[] { "id", "alcohol_allowed", "birthday_parties_allowed", "capacity", "has_pool", "one_night_only" },
                values: new object[,]
                {
                    { 1L, false, true, 6, false, false },
                    { 2L, true, true, 5, true, false },
                    { 3L, false, true, 10, false, false },
                    { 4L, false, true, 5, true, false },
                    { 5L, false, true, 10, false, false },
                    { 6L, false, false, 6, false, false },
                    { 7L, false, true, 10, true, false },
                    { 8L, false, true, 10, false, false },
                    { 9L, false, true, 10, true, false },
                    { 10L, false, true, 10, true, false },
                    { 11L, false, true, 10, false, false },
                    { 12L, false, true, 10, false, false },
                    { 13L, false, true, 10, false, false },
                    { 14L, false, true, 10, false, false },
                    { 15L, false, true, 10, false, false },
                    { 16L, false, true, 10, false, false },
                    { 17L, false, true, 10, false, false },
                    { 18L, false, true, 10, false, false },
                    { 19L, false, true, 10, false, false },
                    { 20L, false, true, 10, false, false },
                    { 21L, false, true, 10, false, false },
                    { 22L, false, true, 10, false, false },
                    { 23L, false, true, 10, false, false },
                    { 24L, false, true, 10, false, false }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 1L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 2L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 3L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 4L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 5L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 6L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 7L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 8L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 9L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 10L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 11L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 12L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 13L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 14L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 15L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 16L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 17L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 18L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 19L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 20L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 21L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 22L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 23L);

            migrationBuilder.DeleteData(
                table: "accommodation_unit_policies",
                keyColumn: "id",
                keyValue: 24L);
        }
    }
}
