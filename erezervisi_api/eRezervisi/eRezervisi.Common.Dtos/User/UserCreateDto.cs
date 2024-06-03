namespace eRezervisi.Common.Dtos.User
{
    public class UserCreateDto
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? ImageBase64 { get; set; }
        public string? ImageFileName { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
    }
}
