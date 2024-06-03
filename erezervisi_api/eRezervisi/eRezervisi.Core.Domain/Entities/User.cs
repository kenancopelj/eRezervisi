using eRezervisi.Core.Domain.Authorization;
using System.ComponentModel.DataAnnotations.Schema;

namespace eRezervisi.Core.Domain.Entities
{
    public class User : BaseEntity<long>
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Image { get; set; }
        public long RoleId { get; set; }
        public Role Role { get; set; } = null!;
        public UserCredentials? UserCredentials { get; set; }
        public UserSettings? UserSettings { get; set; }
        public ICollection<GuestReview>? GuestReviews { get; set; }
        public ICollection<FavoriteAccommodationUnit>? FavoriteAccommodationUnits { get; set; }
        public bool IsActive { get; set; }

        [NotMapped]
        public string Initials => $"{FirstName.First()}{LastName.First()}";

        public string GetFullName()
        {
            return FirstName + " " + LastName;
        }

        public void ChangeRole(long roleId)
        {
            RoleId = roleId;
        }
    }
}
