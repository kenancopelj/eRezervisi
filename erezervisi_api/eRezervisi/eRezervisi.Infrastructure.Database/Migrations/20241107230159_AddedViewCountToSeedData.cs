using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class AddedViewCountToSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 2L,
                column: "view_count",
                value: 10);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 3L,
                column: "view_count",
                value: 4);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 4L,
                column: "view_count",
                value: 25);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 5L,
                column: "view_count",
                value: 3);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 6L,
                column: "view_count",
                value: 9);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 7L,
                column: "view_count",
                value: 15);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 8L,
                column: "view_count",
                value: 12);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 9L,
                column: "view_count",
                value: 13);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 10L,
                column: "view_count",
                value: 20);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 11L,
                column: "view_count",
                value: 19);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 12L,
                column: "view_count",
                value: 30);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 13L,
                column: "view_count",
                value: 1);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 14L,
                column: "view_count",
                value: 10);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 15L,
                column: "view_count",
                value: 3);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 16L,
                column: "view_count",
                value: 19);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 17L,
                column: "view_count",
                value: 21);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 18L,
                column: "view_count",
                value: 17);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 19L,
                column: "view_count",
                value: 21);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 20L,
                column: "view_count",
                value: 4);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 21L,
                column: "view_count",
                value: 2);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 22L,
                column: "view_count",
                value: 33);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 23L,
                column: "view_count",
                value: 25);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 24L,
                column: "view_count",
                value: 17);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 2L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 3L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 4L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 5L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 6L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 7L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 8L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 9L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 10L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 11L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 12L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 13L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 14L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 15L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 16L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 17L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 18L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 19L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 20L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 21L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 22L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 23L,
                column: "view_count",
                value: 0);

            migrationBuilder.UpdateData(
                table: "accommodation_units",
                keyColumn: "id",
                keyValue: 24L,
                column: "view_count",
                value: 0);
        }
    }
}
