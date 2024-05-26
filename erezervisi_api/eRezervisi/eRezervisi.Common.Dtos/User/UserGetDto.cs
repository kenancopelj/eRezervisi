using eRezervisi.Common.Dtos.Role;
using eRezervisi.Common.Dtos.UserSettings;

namespace eRezervisi.Common.Dtos.User
{
    public class UserGetDto
    {
        public long Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Image { get; set; }
        public long RoleId { get; set; }
        public RoleGetDto Role { get; set; } = null!;
        public string Username { get; set; } = null!;
        public UserSettingsGetDto UserSettings { get; set; } = null!;
    }
}
