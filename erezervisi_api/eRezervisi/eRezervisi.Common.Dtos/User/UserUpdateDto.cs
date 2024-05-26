namespace eRezervisi.Common.Dtos.User
{
    public class UserUpdateDto
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Image { get; set; }
        public string Username { get; set; } = null!;
        public string? NewPassword { get; set; } = null!;
    }
}
