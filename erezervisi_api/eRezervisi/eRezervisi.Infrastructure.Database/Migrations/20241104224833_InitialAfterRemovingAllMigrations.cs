using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eRezervisi.Infrastructure.Database.Migrations
{
    /// <inheritdoc />
    public partial class InitialAfterRemovingAllMigrations : Migration
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
                    post_code = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    latitude = table.Column<double>(type: "float", nullable: false),
                    longitude = table.Column<double>(type: "float", nullable: false),
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
                name: "ix_townships_post_code",
                table: "townships",
                column: "post_code");

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
