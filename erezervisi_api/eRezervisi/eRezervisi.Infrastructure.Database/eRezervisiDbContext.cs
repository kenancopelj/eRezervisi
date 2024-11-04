using Microsoft.EntityFrameworkCore;
using eRezervisi.Infrastructure.Common.Interfaces;
using eRezervisi.Core.Domain;
using eRezervisi.Core.Domain.Authorization;
using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Infrastructure.Database
{
    public class eRezervisiDbContext : DbContext
    {
        public eRezervisiDbContext(DbContextOptions options, ICurrentUser currentUser) : base(options)
        {
            _currentUser = currentUser;
        }

        private readonly ICurrentUser _currentUser;

        public DbSet<Role> Roles { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<AccommodationUnit> AccommodationUnits { get; set; }
        public DbSet<AccommodationUnitCategory> AccommodationUnitCategories { get; set; }
        public DbSet<AccommodationUnitReview> AccommodationUnitReviews { get; set; }
        public DbSet<Canton> Cantons { get; set; }
        public DbSet<UserSettings> GeneralSettings { get; set; }
        public DbSet<GuestReview> GuestReviews { get; set; }
        public DbSet<Image> Images { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Reservation> Reservations { get; set; }
        public DbSet<Review> Reviews { get; set; }
        public DbSet<Message> Messages { get; set; }
        public DbSet<Township> Townships { get; set; }
        public DbSet<FavoriteAccommodationUnit> FavoriteAccommodationUnits { get; set; }
        public DbSet<Maintenance> Maintenances { get; set; }
        public DbSet<Recommender> Recommenders { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<AccommodationUnit>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<AccommodationUnitCategory>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Canton>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Image>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Notification>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Reservation>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Review>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Message>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Township>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<User>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<FavoriteAccommodationUnit>().HasQueryFilter(x => !x.Deleted);
            modelBuilder.Entity<Maintenance>().HasQueryFilter(x => !x.Deleted);

            modelBuilder.ApplyConfigurationsFromAssembly(typeof(eRezervisiDbContext).Assembly);

            modelBuilder.Seed();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            CustomSaveChanges();

            return base.SaveChangesAsync(cancellationToken);
        }

        #region Private Methods
        private void CustomSaveChanges()
        {
            var userId = _currentUser.UserId;

            PopulateAuditableColumns();

            void PopulateAuditableColumns()
            {
                var changedAuditableEntries = ChangeTracker
                    .Entries<IAuditable>()
                    .Where(x => x is
                    {
                        State: EntityState.Added or EntityState.Modified or EntityState.Deleted
                    });

                foreach (var entry in changedAuditableEntries)
                {
                    var auditableEntry = entry.Entity;

                    auditableEntry.ModifiedBy = userId;

                    if (entry is { State: EntityState.Added })
                    {
                        auditableEntry.CreatedBy = userId;
                    }

                    if (entry is { State: EntityState.Deleted })
                    {
                        entry.State = EntityState.Modified;
                        auditableEntry.DeletedBy = userId;
                        auditableEntry.DeletedAt = DateTime.Now;
                        auditableEntry.Deleted = true;
                    }
                }
            }
        }

        #endregion
    }
}
