using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class InitialSeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "accommodation_unit_categories",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    short_title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_accommodation_unit_categories", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "cantons",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    short_title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_cantons", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "recommenders",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: true),
                    first_accommodation_unit_id = table.Column<long>(type: "bigint", nullable: true),
                    second_accommodation_unit_id = table.Column<long>(type: "bigint", nullable: true),
                    third_accommodation_unit_id = table.Column<long>(type: "bigint", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_recommenders", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "reviews",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    rating = table.Column<double>(type: "float", nullable: false),
                    note = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_reviews", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "roles",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_roles", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "townships",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    canton_id = table.Column<long>(type: "bigint", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_townships", x => x.id);
                    table.ForeignKey(
                        name: "fk_townships_cantons_canton_id",
                        column: x => x.canton_id,
                        principalTable: "cantons",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "users",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    first_name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    last_name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    phone = table.Column<string>(type: "nvarchar(max)", nullable: false, defaultValue: ""),
                    address = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: false, defaultValue: ""),
                    image = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    role_id = table.Column<long>(type: "bigint", nullable: false),
                    is_active = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_users", x => x.id);
                    table.ForeignKey(
                        name: "fk_users_roles_role_id",
                        column: x => x.role_id,
                        principalTable: "roles",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "accommodation_units",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    price = table.Column<double>(type: "float", nullable: false),
                    owner_id = table.Column<long>(type: "bigint", nullable: false),
                    note = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    accommodation_unit_category_id = table.Column<long>(type: "bigint", nullable: false),
                    status = table.Column<int>(type: "int", nullable: false),
                    thumbnail_image = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    township_id = table.Column<long>(type: "bigint", nullable: false),
                    latitude = table.Column<double>(type: "float", nullable: false),
                    longitude = table.Column<double>(type: "float", nullable: false),
                    address = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    deactivate_at = table.Column<DateOnly>(type: "date", nullable: true),
                    view_count = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_accommodation_units", x => x.id);
                    table.ForeignKey(
                        name: "fk_accommodation_units_accommodation_unit_categories_accommodation_unit_category_id",
                        column: x => x.accommodation_unit_category_id,
                        principalTable: "accommodation_unit_categories",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_accommodation_units_townships_township_id",
                        column: x => x.township_id,
                        principalTable: "townships",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_accommodation_units_users_owner_id",
                        column: x => x.owner_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "guest_reviews",
                columns: table => new
                {
                    review_id = table.Column<long>(type: "bigint", nullable: false),
                    guest_id = table.Column<long>(type: "bigint", nullable: false),
                    user_id = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_guest_reviews", x => new { x.guest_id, x.review_id });
                    table.ForeignKey(
                        name: "fk_guest_reviews_reviews_review_id",
                        column: x => x.review_id,
                        principalTable: "reviews",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_guest_reviews_users_guest_id",
                        column: x => x.guest_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_guest_reviews_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "messages",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    sender_id = table.Column<long>(type: "bigint", nullable: false),
                    receiver_id = table.Column<long>(type: "bigint", nullable: false),
                    content = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_messages", x => x.id);
                    table.ForeignKey(
                        name: "fk_messages_users_receiver_id",
                        column: x => x.receiver_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "fk_messages_users_sender_id",
                        column: x => x.sender_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "notifications",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    user_id = table.Column<long>(type: "bigint", nullable: false),
                    title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    short_title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: true),
                    status = table.Column<int>(type: "int", nullable: false, defaultValueSql: "1"),
                    type = table.Column<int>(type: "int", nullable: false, defaultValueSql: "3"),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_notifications", x => x.id);
                    table.ForeignKey(
                        name: "fk_notifications_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "user_credentials",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false),
                    username = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    password_hash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    password_salt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    refresh_token = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    refresh_token_expires_at_utc = table.Column<DateTime>(type: "datetime2", nullable: true),
                    last_password_change_at = table.Column<DateTime>(type: "datetime2", nullable: false),
                    reminder_sent = table.Column<bool>(type: "bit", nullable: false, defaultValue: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user_credentials", x => x.id);
                    table.ForeignKey(
                        name: "fk_user_credentials_users_id",
                        column: x => x.id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "user_settings",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false),
                    receive_emails = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    receive_notifications = table.Column<bool>(type: "bit", nullable: false, defaultValue: true),
                    mark_object_as_unclean_after_reservation = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_user_settings", x => x.id);
                    table.ForeignKey(
                        name: "fk_user_settings_users_id",
                        column: x => x.id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "accommodation_unit_policies",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false),
                    alcohol_allowed = table.Column<bool>(type: "bit", nullable: false),
                    capacity = table.Column<int>(type: "int", nullable: false),
                    one_night_only = table.Column<bool>(type: "bit", nullable: false),
                    birthday_parties_allowed = table.Column<bool>(type: "bit", nullable: false),
                    has_pool = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_accommodation_unit_policies", x => x.id);
                    table.ForeignKey(
                        name: "fk_accommodation_unit_policies_accommodation_units_id",
                        column: x => x.id,
                        principalTable: "accommodation_units",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "accommodation_unit_reviews",
                columns: table => new
                {
                    review_id = table.Column<long>(type: "bigint", nullable: false),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_accommodation_unit_reviews", x => new { x.review_id, x.accommodation_unit_id });
                    table.ForeignKey(
                        name: "fk_accommodation_unit_reviews_accommodation_units_accommodation_unit_id",
                        column: x => x.accommodation_unit_id,
                        principalTable: "accommodation_units",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_accommodation_unit_reviews_reviews_review_id",
                        column: x => x.review_id,
                        principalTable: "reviews",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "favorite_accommodation_units",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: false),
                    user_id = table.Column<long>(type: "bigint", nullable: true),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_favorite_accommodation_units", x => x.id);
                    table.ForeignKey(
                        name: "fk_favorite_accommodation_units_accommodation_units_accommodation_unit_id",
                        column: x => x.accommodation_unit_id,
                        principalTable: "accommodation_units",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_favorite_accommodation_units_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id");
                });

            migrationBuilder.CreateTable(
                name: "images",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    file_name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_images", x => x.id);
                    table.ForeignKey(
                        name: "fk_images_accommodation_units_accommodation_unit_id",
                        column: x => x.accommodation_unit_id,
                        principalTable: "accommodation_units",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "maintenances",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: false),
                    priority = table.Column<int>(type: "int", nullable: false),
                    status = table.Column<int>(type: "int", nullable: false),
                    note = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_maintenances", x => x.id);
                    table.ForeignKey(
                        name: "fk_maintenances_accommodation_units_accommodation_unit_id",
                        column: x => x.accommodation_unit_id,
                        principalTable: "accommodation_units",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "reservations",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    code = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    user_id = table.Column<long>(type: "bigint", nullable: false),
                    accommodation_unit_id = table.Column<long>(type: "bigint", nullable: false),
                    from = table.Column<DateTime>(type: "datetime2", nullable: false),
                    to = table.Column<DateTime>(type: "datetime2", nullable: false),
                    payment_method = table.Column<int>(type: "int", nullable: false),
                    note = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    status = table.Column<int>(type: "int", nullable: false),
                    number_of_adults = table.Column<int>(type: "int", nullable: false),
                    number_of_children = table.Column<int>(type: "int", nullable: false),
                    total_price = table.Column<double>(type: "float", nullable: false),
                    created_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    created_by = table.Column<long>(type: "bigint", nullable: false),
                    modified_at = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETUTCDATE()"),
                    modified_by = table.Column<long>(type: "bigint", nullable: false),
                    deleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    deleted_at = table.Column<DateTime>(type: "datetime2", nullable: true),
                    deleted_by = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_reservations", x => x.id);
                    table.ForeignKey(
                        name: "fk_reservations_accommodation_units_accommodation_unit_id",
                        column: x => x.accommodation_unit_id,
                        principalTable: "accommodation_units",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "fk_reservations_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.InsertData(
                table: "accommodation_unit_categories",
                columns: new[] { "id", "created_by", "deleted_at", "deleted_by", "modified_by", "short_title", "title" },
                values: new object[,]
                {
                    { 1L, 0L, null, null, 0L, "APT", "Apartmani" },
                    { 2L, 0L, null, null, 0L, "VIL", "Ville" },
                    { 3L, 0L, null, null, 0L, "VIK", "Vikendice" },
                    { 4L, 0L, null, null, 0L, "PRI", "Privatne kuće" },
                    { 5L, 0L, null, null, 0L, "BGL", "Bungalovi" }
                });

            migrationBuilder.InsertData(
                table: "cantons",
                columns: new[] { "id", "created_by", "deleted_at", "deleted_by", "modified_by", "short_title", "title" },
                values: new object[,]
                {
                    { 1L, 0L, null, null, 0L, "USK", "Unsko-sanski kanton" },
                    { 2L, 0L, null, null, 0L, "PK", "Posavski kanton" },
                    { 3L, 0L, null, null, 0L, "TK", "Tuzlanski kanton" },
                    { 4L, 0L, null, null, 0L, "ZDK", "Zeničko-dobojski kanton" },
                    { 5L, 0L, null, null, 0L, "BPK", "Bosansko-podrinjski kanton" },
                    { 6L, 0L, null, null, 0L, "SBK", "Srednjobosanski kanton" },
                    { 7L, 0L, null, null, 0L, "HNK", "Herecegovačko-neretvanski kanton" },
                    { 8L, 0L, null, null, 0L, "ZHK", "Zapadnohercegovački kanton" },
                    { 9L, 0L, null, null, 0L, "KS", "Kanton Sarajevo" },
                    { 10L, 0L, null, null, 0L, "K10", "Kanton 10" },
                    { 11L, 0L, null, null, 0L, "RS", "Republika Srpksa" }
                });

            migrationBuilder.InsertData(
                table: "roles",
                columns: new[] { "id", "created_by", "deleted_at", "deleted_by", "modified_by", "name" },
                values: new object[,]
                {
                    { 1L, 0L, null, null, 0L, "Owner" },
                    { 2L, 0L, null, null, 0L, "MobileUser" }
                });

            migrationBuilder.InsertData(
                table: "townships",
                columns: new[] { "id", "canton_id", "created_by", "deleted_at", "deleted_by", "modified_by", "title" },
                values: new object[,]
                {
                    { 1L, 1L, 0L, null, null, 0L, "Bihać" },
                    { 2L, 1L, 0L, null, null, 0L, "Bosanska Krupa" },
                    { 3L, 1L, 0L, null, null, 0L, "Bosanski Petrovac" },
                    { 4L, 1L, 0L, null, null, 0L, "Bužim" },
                    { 5L, 1L, 0L, null, null, 0L, "Cazin" },
                    { 6L, 1L, 0L, null, null, 0L, "Ključ" },
                    { 7L, 1L, 0L, null, null, 0L, "Sanski Most" },
                    { 8L, 1L, 0L, null, null, 0L, "Velika Kladuša" },
                    { 9L, 2L, 0L, null, null, 0L, "Domaljevac-Šamac" },
                    { 10L, 2L, 0L, null, null, 0L, "Odžak" },
                    { 11L, 2L, 0L, null, null, 0L, "Orašje" },
                    { 12L, 3L, 0L, null, null, 0L, "Banovići" },
                    { 13L, 3L, 0L, null, null, 0L, "Čelić" },
                    { 14L, 3L, 0L, null, null, 0L, "Doboj Istok" },
                    { 15L, 3L, 0L, null, null, 0L, "Gračanica" },
                    { 16L, 3L, 0L, null, null, 0L, "Gradačac" },
                    { 17L, 3L, 0L, null, null, 0L, "Kalesija" },
                    { 18L, 3L, 0L, null, null, 0L, "Kladanj" },
                    { 19L, 3L, 0L, null, null, 0L, "Lukavac" },
                    { 20L, 3L, 0L, null, null, 0L, "Sapna" },
                    { 21L, 3L, 0L, null, null, 0L, "Srebrenik" },
                    { 22L, 3L, 0L, null, null, 0L, "Teočak" },
                    { 23L, 3L, 0L, null, null, 0L, "Tuzla" },
                    { 24L, 3L, 0L, null, null, 0L, "Živinice" },
                    { 25L, 4L, 0L, null, null, 0L, "Breza" },
                    { 26L, 4L, 0L, null, null, 0L, "Doboj Jug" },
                    { 27L, 4L, 0L, null, null, 0L, "Kakanj" },
                    { 28L, 4L, 0L, null, null, 0L, "Maglaj" },
                    { 29L, 4L, 0L, null, null, 0L, "Olovo" },
                    { 30L, 4L, 0L, null, null, 0L, "Tešanj" },
                    { 31L, 4L, 0L, null, null, 0L, "Usora" },
                    { 32L, 4L, 0L, null, null, 0L, "Vareš" },
                    { 33L, 4L, 0L, null, null, 0L, "Visoko" },
                    { 34L, 4L, 0L, null, null, 0L, "Zavidovići" },
                    { 35L, 4L, 0L, null, null, 0L, "Zenica" },
                    { 36L, 4L, 0L, null, null, 0L, "Žepče" },
                    { 37L, 5L, 0L, null, null, 0L, "Foča" },
                    { 38L, 5L, 0L, null, null, 0L, "Goražde" },
                    { 39L, 5L, 0L, null, null, 0L, "Pale" },
                    { 40L, 6L, 0L, null, null, 0L, "Bugojno" },
                    { 41L, 6L, 0L, null, null, 0L, "Busovača" },
                    { 42L, 6L, 0L, null, null, 0L, "Dobretići" },
                    { 43L, 6L, 0L, null, null, 0L, "Donji Vakuf" },
                    { 44L, 6L, 0L, null, null, 0L, "Fojnica" },
                    { 45L, 6L, 0L, null, null, 0L, "Gornji Vakuf-Uskoplje" },
                    { 46L, 6L, 0L, null, null, 0L, "Jajce" },
                    { 47L, 6L, 0L, null, null, 0L, "Kiseljak" },
                    { 48L, 6L, 0L, null, null, 0L, "Kreševo" },
                    { 49L, 6L, 0L, null, null, 0L, "Novi Travnik" },
                    { 50L, 6L, 0L, null, null, 0L, "Travnik" },
                    { 51L, 6L, 0L, null, null, 0L, "Vitez" },
                    { 52L, 7L, 0L, null, null, 0L, "Čapljina" },
                    { 53L, 7L, 0L, null, null, 0L, "Jablanica" },
                    { 54L, 7L, 0L, null, null, 0L, "Konjic" },
                    { 55L, 7L, 0L, null, null, 0L, "Mostar" },
                    { 56L, 7L, 0L, null, null, 0L, "Neum" },
                    { 57L, 7L, 0L, null, null, 0L, "Prozor-Rama" },
                    { 58L, 7L, 0L, null, null, 0L, "Ravno" },
                    { 59L, 7L, 0L, null, null, 0L, "Stolac" },
                    { 60L, 8L, 0L, null, null, 0L, "Grude" },
                    { 61L, 8L, 0L, null, null, 0L, "Ljubuški" },
                    { 62L, 8L, 0L, null, null, 0L, "Posušje" },
                    { 63L, 8L, 0L, null, null, 0L, "Široki Brijeg" },
                    { 64L, 9L, 0L, null, null, 0L, "Centar" },
                    { 65L, 9L, 0L, null, null, 0L, "Novi Grad" },
                    { 66L, 9L, 0L, null, null, 0L, "Novo Sarajevo" },
                    { 67L, 9L, 0L, null, null, 0L, "Stari Grad" },
                    { 68L, 9L, 0L, null, null, 0L, "Sarajevo" },
                    { 69L, 9L, 0L, null, null, 0L, "Hadžići" },
                    { 70L, 9L, 0L, null, null, 0L, "Ilidža" },
                    { 71L, 9L, 0L, null, null, 0L, "Ilijaš" },
                    { 72L, 9L, 0L, null, null, 0L, "Trnovo" },
                    { 73L, 9L, 0L, null, null, 0L, "Vogošća" },
                    { 74L, 10L, 0L, null, null, 0L, "Bosansko Grahovo" },
                    { 75L, 10L, 0L, null, null, 0L, "Drvar" },
                    { 76L, 10L, 0L, null, null, 0L, "Glamoč" },
                    { 77L, 10L, 0L, null, null, 0L, "Kupres" },
                    { 78L, 10L, 0L, null, null, 0L, "Livno" },
                    { 79L, 10L, 0L, null, null, 0L, "Tomislavgrad" },
                    { 80L, 11L, 0L, null, null, 0L, "Banja Luka" },
                    { 81L, 11L, 0L, null, null, 0L, "Trebinje" },
                    { 82L, 11L, 0L, null, null, 0L, "Zvornik" },
                    { 83L, 11L, 0L, null, null, 0L, "Prijedor" },
                    { 84L, 11L, 0L, null, null, 0L, "Gradiška" },
                    { 85L, 11L, 0L, null, null, 0L, "Derventa" },
                    { 86L, 11L, 0L, null, null, 0L, "Bijeljina" },
                    { 87L, 11L, 0L, null, null, 0L, "Doboj" }
                });

            migrationBuilder.InsertData(
                table: "users",
                columns: new[] { "id", "address", "created_by", "deleted_at", "deleted_by", "email", "first_name", "image", "is_active", "last_name", "modified_by", "phone", "role_id" },
                values: new object[,]
                {
                    { 1L, "Opine b.b", 0L, null, null, "kenan.copelj@edu.fit.ba", "Owner", null, true, "User", 0L, "+387616161", 1L },
                    { 2L, "0000", 0L, null, null, "kenan.copelj@edu.fit.ba", "Regular", null, true, "User", 0L, "0000", 2L },
                    { 3L, "123 Main St", 0L, null, null, "emma.watson@domain.com", "Emma", null, true, "Watson", 0L, "+38761234501", 1L },
                    { 4L, "456 Elm St", 0L, null, null, "liam.johnson@domain.com", "Liam", null, true, "Johnson", 0L, "+38761234502", 1L },
                    { 5L, "789 Maple Ave", 0L, null, null, "olivia.brown@domain.com", "Olivia", null, true, "Brown", 0L, "+38761234503", 2L },
                    { 6L, "101 Oak Rd", 0L, null, null, "noah.williams@domain.com", "Noah", null, true, "Williams", 0L, "+38761234504", 2L },
                    { 7L, "202 Pine St", 0L, null, null, "ava.jones@domain.com", "Ava", null, true, "Jones", 0L, "+38761234505", 2L },
                    { 8L, "303 Cedar Ave", 0L, null, null, "mason.garcia@domain.com", "Mason", null, true, "Garcia", 0L, "+38761234506", 2L },
                    { 9L, "404 Birch Blvd", 0L, null, null, "sophia.martinez@domain.com", "Sophia", null, true, "Martinez", 0L, "+38761234507", 2L },
                    { 10L, "505 Willow Way", 0L, null, null, "lucas.anderson@domain.com", "Lucas", null, true, "Anderson", 0L, "+38761234508", 2L },
                    { 11L, "606 Chestnut St", 0L, null, null, "amelia.thomas@domain.com", "Amelia", null, true, "Thomas", 0L, "+38761234509", 2L },
                    { 12L, "707 Spruce Ave", 0L, null, null, "ethan.lee@domain.com", "Ethan", null, true, "Lee", 0L, "+38761234510", 2L },
                    { 13L, "808 Redwood Rd", 0L, null, null, "isabella.davis@domain.com", "Isabella", null, true, "Davis", 0L, "+38761234511", 2L },
                    { 14L, "909 Fir Ln", 0L, null, null, "logan.wilson@domain.com", "Logan", null, true, "Wilson", 0L, "+38761234512", 2L },
                    { 15L, "1010 Palm St", 0L, null, null, "mia.hernandez@domain.com", "Mia", null, true, "Hernandez", 0L, "+38761234513", 2L },
                    { 16L, "1111 Maplewood Dr", 0L, null, null, "james.robinson@domain.com", "James", null, true, "Robinson", 0L, "+38761234514", 2L },
                    { 17L, "1212 Pinewood Ln", 0L, null, null, "harper.clark@domain.com", "Harper", null, true, "Clark", 0L, "+38761234515", 2L }
                });

            migrationBuilder.InsertData(
                table: "accommodation_units",
                columns: new[] { "id", "accommodation_unit_category_id", "address", "created_by", "deactivate_at", "deleted_at", "deleted_by", "latitude", "longitude", "modified_by", "note", "owner_id", "price", "status", "thumbnail_image", "title", "township_id" },
                values: new object[,]
                {
                    { 1L, 1L, "Mula Mustafe Bašeskije", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 1L, 150.0, 1, "63f06b1f-f76e-45b7-82ed-0631381f85fc_VistaSarajevoThumb.jpg", "Central Vista Apartments Sarajevo", 66L },
                    { 2L, 2L, "Pehlivanuša 67", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 1L, 898.0, 1, "55899be7-94fe-40b8-84a0-b66b00b022c8_OneLoveThumb.jpg", "One Love", 68L },
                    { 3L, 1L, "Soldina 3", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 3L, 369.0, 1, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_CittaThumb.jpg", "Apartment Citta Vecchia", 55L },
                    { 4L, 2L, "II. bojne rudničke 185A", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 3L, 369.0, 1, "49f38bd6-1d31-4458-997d-b5739e5d7fda_FlumenThumb.jpg", "Villa Flumen", 55L },
                    { 5L, 2L, "Alice Rizikala, 8 I sprat, zgrada", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 4L, 450.0, 1, "88af37ec-030c-45d4-9045-b941843e8c30_MostarThumb.jpg", "Villa Mostar", 55L },
                    { 6L, 5L, "Ferida Srnje 16", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 4L, 300.0, 1, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo.jpg", "Bungalovi Sarajevo", 68L },
                    { 7L, 2L, "15 Fra Grge Martića", 0L, null, null, null, 43.856430000000003, 18.413029000000002, 0L, null, 3L, 250.0, 1, "bebefb25-41da-474b-8bcb-fdd291162409_RoyalThumb.jpg", "Apartman ROYAL Bulvear", 35L },
                    { 8L, 3L, "Vladislava Skarića 5", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 4L, 200.0, 1, "924B4AF0-91E3-4FDD-A248-77B9D9025F7C_VacationVibesThumb.jpg", "Apartment Europe Sarajevo", 68L },
                    { 9L, 3L, "Hrasnička cesta bb", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 230.0, 1, "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak.jpg", "Malak Regency Apartment", 67L },
                    { 10L, 3L, "Kneza Domagoja bb", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 1L, 180.0, 1, "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar.jpg", "Bungalovi Mostar", 65L },
                    { 11L, 3L, "Fra Filipa Lastrića 2", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 220.0, 1, "F64F818A-51D1-4554-997E-B912BFB642D4_Bristol.jpg", "Bristol", 55L },
                    { 12L, 3L, "Ravne 1", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 250.0, 1, "AAD0545E-D5EA-41E8-AD27-692B07CEA75A_PinoNature.jpg", "Pino Nature", 55L },
                    { 13L, 1L, "Cara Dušana 10", 0L, null, null, null, 44.7333, 18.083300000000001, 0L, null, 3L, 160.0, 1, "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj.jpg", "Villa Park Doboj", 87L },
                    { 14L, 3L, "Babanovac Bb", 0L, null, null, null, 44.311500000000002, 17.594999999999999, 0L, null, 4L, 280.0, 1, "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca.jpg", "Blanca Resort & Spa", 55L },
                    { 15L, 1L, "Kralja Tomislava bb", 0L, null, null, null, 43.121600000000001, 17.684100000000001, 0L, null, 4L, 140.0, 1, "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo.jpg", "Villa Mogorjelo", 52L },
                    { 16L, 2L, "Cvijetni trg 1", 0L, null, null, null, 42.708599999999997, 18.328299999999999, 0L, null, 1L, 190.0, 1, "f860fff9-e427-4c4f-aade-871b1a7f684a_Platan.jpg", "Apartman Platani", 81L },
                    { 17L, 2L, "Lacina 9a", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 1L, 150.0, 1, "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar.jpg", "Nar Mostar", 55L },
                    { 18L, 1L, "Lacina bb", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 1L, 170.0, 1, "dfca9935-bc56-4218-ae2e-d472d2227526_Park.jpg", "Villa Park", 71L },
                    { 19L, 2L, "Kameni Spavač bb", 0L, null, null, null, 44.203600000000002, 17.907299999999999, 0L, null, 3L, 200.0, 1, "e6031584-3134-4580-9bd7-ead07fba6740_Kenan.jpg", "Apartman Kenan", 12L },
                    { 20L, 1L, "Ski Resort, Mostar", 0L, null, null, null, 43.343800000000002, 17.8078, 0L, null, 3L, 240.0, 1, "55250ffc-4450-4dc4-b5e3-a62ce5cb2bc3_Snjezna.jpg", "Hotel Snježna Kuća", 40L },
                    { 21L, 3L, "Ulica fra Slavka Barbarića", 0L, null, null, null, 43.186399999999999, 17.679099999999998, 0L, null, 4L, 210.0, 1, "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje.jpg", "Medjugorje Apartman", 48L },
                    { 22L, 1L, "Blagaj Bb", 0L, null, null, null, 43.255099999999999, 17.886399999999998, 0L, null, 4L, 160.0, 1, "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj.jpg", "Villa Blagaj", 55L },
                    { 23L, 3L, "Brijesce bb", 0L, null, null, null, 43.856299999999997, 18.4131, 0L, null, 1L, 250.0, 1, "9e726f37-6721-418c-b7da-5a8e80e1651c_Hercegovina.jpg", "Hercegovina", 65L },
                    { 24L, 1L, "Trg Državnosti bb", 0L, null, null, null, 43.654499999999999, 17.962700000000002, 0L, null, 3L, 150.0, 1, "e4df6297-a151-413a-8241-c480fb27e289_Konjic.jpg", "Villa Konjic", 54L }
                });

            migrationBuilder.InsertData(
                table: "user_credentials",
                columns: new[] { "id", "last_password_change_at", "password_hash", "password_salt", "refresh_token", "refresh_token_expires_at_utc", "username" },
                values: new object[,]
                {
                    { 1L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "desktop" },
                    { 2L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "mobile" },
                    { 3L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "emmawatson" },
                    { 4L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "liamjohnson" },
                    { 5L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "oliviabrown" },
                    { 6L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "noahwilliams" },
                    { 7L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "avajones" },
                    { 8L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "masongarcia" },
                    { 9L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "sophiamartinez" },
                    { 10L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "lucasanderson" },
                    { 11L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "ameliathomas" },
                    { 12L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "ethanlee" },
                    { 13L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "isabelladavis" },
                    { 14L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "loganwilson" },
                    { 15L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "miahernandez" },
                    { 16L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "jamesrobinson" },
                    { 17L, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "22b46813685cbb9ce130ee451b78c820222740d47150a04a925778474898a90a", "d87fb28197dc4c88a790d5c31ff4d355", null, null, "harperclark" }
                });

            migrationBuilder.InsertData(
                table: "user_settings",
                columns: new[] { "id", "mark_object_as_unclean_after_reservation", "receive_emails", "receive_notifications" },
                values: new object[,]
                {
                    { 1L, false, true, true },
                    { 2L, false, true, true },
                    { 3L, false, true, true },
                    { 4L, false, true, true },
                    { 5L, false, true, true },
                    { 6L, false, true, true },
                    { 7L, false, true, true },
                    { 8L, false, true, true },
                    { 9L, false, true, true },
                    { 10L, false, true, true },
                    { 11L, false, true, true },
                    { 12L, false, true, true },
                    { 13L, false, true, true },
                    { 14L, false, true, true },
                    { 15L, false, true, true },
                    { 16L, false, true, true },
                    { 17L, false, true, true }
                });

            migrationBuilder.InsertData(
                table: "images",
                columns: new[] { "id", "accommodation_unit_id", "created_by", "deleted_at", "deleted_by", "file_name", "modified_by" },
                values: new object[,]
                {
                    { 1L, 1L, 0L, null, null, "0befdb86-650f-430d-814e-76d6a220a70e_VistaSarajevo1.jpg", 0L },
                    { 2L, 1L, 0L, null, null, "3d768381-62a7-4cf7-bb2d-5d7a2cb9130f_VistaSarajevo2.jpg", 0L },
                    { 3L, 1L, 0L, null, null, "4f458512-3235-4f25-9fc4-c31c3659869c_VistaSarajevo3.jpg", 0L },
                    { 4L, 2L, 0L, null, null, "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove1.jpg", 0L },
                    { 5L, 2L, 0L, null, null, "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove2.jpg", 0L },
                    { 6L, 2L, 0L, null, null, "c0c1aeaa-adca-4ebe-aa23-1b6c04eeab86_OneLove3.jpg", 0L },
                    { 7L, 3L, 0L, null, null, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta1.jpg", 0L },
                    { 8L, 3L, 0L, null, null, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta2.jpg", 0L },
                    { 9L, 3L, 0L, null, null, "f9d7eb2e-1ca3-42e4-8b0c-c901492d238e_Citta3.jpg", 0L },
                    { 10L, 4L, 0L, null, null, "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen1.jpg", 0L },
                    { 11L, 4L, 0L, null, null, "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen2.jpg", 0L },
                    { 12L, 4L, 0L, null, null, "49f38bd6-1d31-4458-997d-b5739e5d7fda_Flumen3.jpg", 0L },
                    { 13L, 5L, 0L, null, null, "88af37ec-030c-45d4-9045-b941843e8c30_Mostar1.jpg", 0L },
                    { 14L, 5L, 0L, null, null, "88af37ec-030c-45d4-9045-b941843e8c30_Mostar2.jpg", 0L },
                    { 15L, 5L, 0L, null, null, "88af37ec-030c-45d4-9045-b941843e8c30_Mostar3.jpg", 0L },
                    { 16L, 6L, 0L, null, null, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo1.jpg", 0L },
                    { 17L, 6L, 0L, null, null, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo2.jpg", 0L },
                    { 18L, 6L, 0L, null, null, "74d8c129-57dd-42b9-8f7d-903f6aa04398_BungaloviSarajevo3.jpg", 0L },
                    { 19L, 7L, 0L, null, null, "bebefb25-41da-474b-8bcb-fdd291162409_Royal1.jpg", 0L },
                    { 20L, 7L, 0L, null, null, "bebefb25-41da-474b-8bcb-fdd291162409_Royal2.jpg", 0L },
                    { 21L, 7L, 0L, null, null, "bebefb25-41da-474b-8bcb-fdd291162409_Royal3.jpg", 0L },
                    { 22L, 8L, 0L, null, null, "924B4AF0-91E3-4FDD-A248-77B9D9025F7C_VacationVibes1.jpg", 0L },
                    { 23L, 8L, 0L, null, null, "924B4AF0-91E3-4FDD-A248-77B9D9025F7C_VacationVibes2.jpg", 0L },
                    { 24L, 9L, 0L, null, null, "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak1.jpg", 0L },
                    { 25L, 9L, 0L, null, null, "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak2.jpg", 0L },
                    { 26L, 9L, 0L, null, null, "FE0B968E-E508-49A5-9616-2E47C3C94B09_Malak3.jpg", 0L },
                    { 27L, 10L, 0L, null, null, "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar1.jpg", 0L },
                    { 28L, 10L, 0L, null, null, "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar2.jpg", 0L },
                    { 29L, 10L, 0L, null, null, "7176BEE4-B05D-4097-A8B4-123EEFA50183_BungaloviMostar3.jpg", 0L },
                    { 30L, 11L, 0L, null, null, "F64F818A-51D1-4554-997E-B912BFB642D4_Bristol1.jpg", 0L },
                    { 31L, 11L, 0L, null, null, "F64F818A-51D1-4554-997E-B912BFB642D4_Bristol2.jpg", 0L },
                    { 32L, 12L, 0L, null, null, "AAD0545E-D5EA-41E8-AD27-692B07CEA75A_PinoNature1.jpg", 0L },
                    { 33L, 12L, 0L, null, null, "AAD0545E-D5EA-41E8-AD27-692B07CEA75A_PinoNature2.jpg", 0L },
                    { 34L, 13L, 0L, null, null, "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj1.jpg", 0L },
                    { 35L, 13L, 0L, null, null, "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj2.jpg", 0L },
                    { 36L, 13L, 0L, null, null, "27BDBCAC-CC92-45D4-A5E4-DA36AAF30C28_VillaParkDoboj3.jpg", 0L },
                    { 37L, 14L, 0L, null, null, "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca1.jpg", 0L },
                    { 38L, 14L, 0L, null, null, "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca2.jpg", 0L },
                    { 39L, 15L, 0L, null, null, "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo1.jpg", 0L },
                    { 40L, 15L, 0L, null, null, "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo2.jpg", 0L },
                    { 41L, 15L, 0L, null, null, "5288e9c6-6263-4e3d-b6b0-be001bc7cb6f_Mogorjelo3.jpg", 0L },
                    { 42L, 16L, 0L, null, null, "f860fff9-e427-4c4f-aade-871b1a7f684a_Platan1.jpg", 0L },
                    { 43L, 16L, 0L, null, null, "f860fff9-e427-4c4f-aade-871b1a7f684a_Platan2.jpg", 0L },
                    { 44L, 17L, 0L, null, null, "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar1.jpg", 0L },
                    { 45L, 17L, 0L, null, null, "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar2.jpg", 0L },
                    { 47L, 17L, 0L, null, null, "bc18cea3-63e5-4d27-8609-2be0b40f5723_Nar3.jpg", 0L },
                    { 48L, 18L, 0L, null, null, "dfca9935-bc56-4218-ae2e-d472d2227526_Park1.jpg", 0L },
                    { 49L, 18L, 0L, null, null, "dfca9935-bc56-4218-ae2e-d472d2227526_Park2.jpg", 0L },
                    { 50L, 19L, 0L, null, null, "e6031584-3134-4580-9bd7-ead07fba6740_Kenan1.jpg", 0L },
                    { 51L, 19L, 0L, null, null, "e6031584-3134-4580-9bd7-ead07fba6740_Kenan2.jpg", 0L },
                    { 52L, 19L, 0L, null, null, "e6031584-3134-4580-9bd7-ead07fba6740_Kenan3.jpg", 0L },
                    { 53L, 20L, 0L, null, null, "55250ffc-4450-4dc4-b5e3-a62ce5cb2bc3_Snjezna1.jpg", 0L },
                    { 54L, 20L, 0L, null, null, "55250ffc-4450-4dc4-b5e3-a62ce5cb2bc3_Snjezna2.jpg", 0L },
                    { 55L, 21L, 0L, null, null, "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje1.jpg", 0L },
                    { 56L, 21L, 0L, null, null, "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje2.jpg", 0L },
                    { 57L, 21L, 0L, null, null, "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje3.jpg", 0L },
                    { 58L, 21L, 0L, null, null, "493a1834-1a18-4b5c-b683-13881006d05f_Medjugorje4.jpg", 0L },
                    { 59L, 22L, 0L, null, null, "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj1.jpg", 0L },
                    { 60L, 22L, 0L, null, null, "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj2.jpg", 0L },
                    { 61L, 22L, 0L, null, null, "ec5b0ebb-1c31-4692-a049-45c606b1a410_Blagaj3.jpg", 0L },
                    { 62L, 23L, 0L, null, null, "9e726f37-6721-418c-b7da-5a8e80e1651c_Hercegovina1.jpg", 0L },
                    { 63L, 23L, 0L, null, null, "9e726f37-6721-418c-b7da-5a8e80e1651c_Hercegovina2.jpg", 0L },
                    { 64L, 24L, 0L, null, null, "e4df6297-a151-413a-8241-c480fb27e289_Konjic1.jpg", 0L },
                    { 65L, 24L, 0L, null, null, "e4df6297-a151-413a-8241-c480fb27e289_Konjic2.jpg", 0L },
                    { 66L, 24L, 0L, null, null, "e4df6297-a151-413a-8241-c480fb27e289_Konjic3.jpg", 0L },
                    { 67L, 24L, 0L, null, null, "e4df6297-a151-413a-8241-c480fb27e289_Konjic4.jpg", 0L },
                    { 68L, 14L, 0L, null, null, "391578c6-cccd-4622-bd1a-40cdbdab1217_Blanca3.jpg", 0L }
                });

            migrationBuilder.InsertData(
                table: "reservations",
                columns: new[] { "id", "accommodation_unit_id", "code", "created_by", "deleted_at", "deleted_by", "from", "modified_by", "note", "number_of_adults", "number_of_children", "payment_method", "status", "to", "total_price", "user_id" },
                values: new object[,]
                {
                    { 1L, 1L, "1/2024", 0L, null, null, new DateTime(2024, 5, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 2, 6, new DateTime(2024, 5, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), 750.0, 2L },
                    { 2L, 1L, "2/2024", 0L, null, null, new DateTime(2024, 3, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 4, 2, 1, 6, new DateTime(2024, 3, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 2400.0, 5L },
                    { 3L, 1L, "3/2024", 0L, null, null, new DateTime(2024, 4, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 1, 6, new DateTime(2024, 4, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), 2400.0, 11L },
                    { 4L, 1L, "28/2024", 0L, null, null, new DateTime(2024, 4, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 2, 1, 6, new DateTime(2024, 4, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 600.0, 15L },
                    { 5L, 1L, "29/2024", 0L, null, null, new DateTime(2024, 4, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 6, new DateTime(2024, 4, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 300.0, 15L },
                    { 6L, 1L, "24/2024", 0L, null, null, new DateTime(2024, 4, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 6, new DateTime(2024, 4, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), 300.0, 15L },
                    { 7L, 2L, "7/2024", 0L, null, null, new DateTime(2024, 2, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 2, 6, new DateTime(2024, 2, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 500.0, 5L },
                    { 8L, 3L, "8/2024", 0L, null, null, new DateTime(2024, 3, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 1, 2, 1, 2, new DateTime(2024, 3, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 450.0, 6L },
                    { 9L, 1L, "9/2024", 0L, null, null, new DateTime(2024, 4, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 2, 3, new DateTime(2024, 4, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 600.0, 7L },
                    { 10L, 4L, "10/2024", 0L, null, null, new DateTime(2024, 5, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 6, new DateTime(2024, 5, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 520.0, 8L },
                    { 11L, 5L, "11/2024", 0L, null, null, new DateTime(2024, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 4, 0, 2, 2, new DateTime(2024, 6, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 700.0, 9L },
                    { 12L, 6L, "12/2024", 0L, null, null, new DateTime(2024, 7, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 2, new DateTime(2024, 7, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 480.0, 10L },
                    { 13L, 7L, "13/2024", 0L, null, null, new DateTime(2024, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 2, 2, 6, new DateTime(2024, 8, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), 620.0, 11L },
                    { 14L, 1L, "14/2024", 0L, null, null, new DateTime(2024, 9, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 2, new DateTime(2024, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 520.0, 12L },
                    { 15L, 2L, "15/2024", 0L, null, null, new DateTime(2024, 10, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 4, 0, 2, 6, new DateTime(2024, 10, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 750.0, 13L },
                    { 16L, 3L, "16/2024", 0L, null, null, new DateTime(2024, 11, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 1, new DateTime(2024, 11, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), 320.0, 14L },
                    { 17L, 4L, "17/2024", 0L, null, null, new DateTime(2024, 11, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 1, 0, 2, 1, new DateTime(2024, 11, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), 250.0, 5L },
                    { 18L, 5L, "18/2024", 0L, null, null, new DateTime(2024, 11, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 1, new DateTime(2024, 11, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), 300.0, 6L },
                    { 19L, 6L, "19/2024", 0L, null, null, new DateTime(2024, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 2, 1, new DateTime(2024, 11, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), 400.0, 7L },
                    { 20L, 7L, "20/2024", 0L, null, null, new DateTime(2024, 12, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 0, 1, 2, new DateTime(2024, 12, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), 380.0, 8L },
                    { 21L, 1L, "21/2024", 0L, null, null, new DateTime(2024, 3, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 2, 1, 1, 6, new DateTime(2024, 3, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), 340.0, 9L },
                    { 22L, 2L, "22/2024", 0L, null, null, new DateTime(2024, 4, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 1, 2, 2, 2, new DateTime(2024, 4, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), 410.0, 10L },
                    { 23L, 3L, "23/2024", 0L, null, null, new DateTime(2024, 5, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 0L, null, 3, 1, 1, 3, new DateTime(2024, 5, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), 530.0, 11L }
                });

            migrationBuilder.CreateIndex(
                name: "ix_accommodation_unit_reviews_accommodation_unit_id",
                table: "accommodation_unit_reviews",
                column: "accommodation_unit_id");

            migrationBuilder.CreateIndex(
                name: "ix_accommodation_units_accommodation_unit_category_id",
                table: "accommodation_units",
                column: "accommodation_unit_category_id");

            migrationBuilder.CreateIndex(
                name: "ix_accommodation_units_owner_id",
                table: "accommodation_units",
                column: "owner_id");

            migrationBuilder.CreateIndex(
                name: "ix_accommodation_units_township_id",
                table: "accommodation_units",
                column: "township_id");

            migrationBuilder.CreateIndex(
                name: "ix_favorite_accommodation_units_accommodation_unit_id",
                table: "favorite_accommodation_units",
                column: "accommodation_unit_id");

            migrationBuilder.CreateIndex(
                name: "ix_favorite_accommodation_units_user_id",
                table: "favorite_accommodation_units",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "ix_guest_reviews_review_id",
                table: "guest_reviews",
                column: "review_id");

            migrationBuilder.CreateIndex(
                name: "ix_guest_reviews_user_id",
                table: "guest_reviews",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "ix_images_accommodation_unit_id",
                table: "images",
                column: "accommodation_unit_id");

            migrationBuilder.CreateIndex(
                name: "ix_maintenances_accommodation_unit_id",
                table: "maintenances",
                column: "accommodation_unit_id");

            migrationBuilder.CreateIndex(
                name: "ix_messages_receiver_id",
                table: "messages",
                column: "receiver_id");

            migrationBuilder.CreateIndex(
                name: "ix_messages_sender_id",
                table: "messages",
                column: "sender_id");

            migrationBuilder.CreateIndex(
                name: "ix_notifications_user_id",
                table: "notifications",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "ix_reservations_accommodation_unit_id",
                table: "reservations",
                column: "accommodation_unit_id");

            migrationBuilder.CreateIndex(
                name: "ix_reservations_code",
                table: "reservations",
                column: "code",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_reservations_user_id",
                table: "reservations",
                column: "user_id");

            migrationBuilder.CreateIndex(
                name: "ix_townships_canton_id",
                table: "townships",
                column: "canton_id");

            migrationBuilder.CreateIndex(
                name: "ix_user_credentials_refresh_token",
                table: "user_credentials",
                column: "refresh_token",
                unique: true,
                filter: "[refresh_token] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "ix_user_credentials_username",
                table: "user_credentials",
                column: "username",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "ix_users_role_id",
                table: "users",
                column: "role_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "accommodation_unit_policies");

            migrationBuilder.DropTable(
                name: "accommodation_unit_reviews");

            migrationBuilder.DropTable(
                name: "favorite_accommodation_units");

            migrationBuilder.DropTable(
                name: "guest_reviews");

            migrationBuilder.DropTable(
                name: "images");

            migrationBuilder.DropTable(
                name: "maintenances");

            migrationBuilder.DropTable(
                name: "messages");

            migrationBuilder.DropTable(
                name: "notifications");

            migrationBuilder.DropTable(
                name: "recommenders");

            migrationBuilder.DropTable(
                name: "reservations");

            migrationBuilder.DropTable(
                name: "user_credentials");

            migrationBuilder.DropTable(
                name: "user_settings");

            migrationBuilder.DropTable(
                name: "reviews");

            migrationBuilder.DropTable(
                name: "accommodation_units");

            migrationBuilder.DropTable(
                name: "accommodation_unit_categories");

            migrationBuilder.DropTable(
                name: "townships");

            migrationBuilder.DropTable(
                name: "users");

            migrationBuilder.DropTable(
                name: "cantons");

            migrationBuilder.DropTable(
                name: "roles");
        }
    }
}
