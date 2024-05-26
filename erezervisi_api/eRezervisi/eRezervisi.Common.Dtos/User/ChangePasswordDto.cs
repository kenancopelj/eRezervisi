namespace eRezervisi.Common.Dtos.User
{
    public class ChangePasswordDto
    {
        public string Username { get; set; } = null!;
        public string? NewPassword { get; set; } = null!;
    }
}
