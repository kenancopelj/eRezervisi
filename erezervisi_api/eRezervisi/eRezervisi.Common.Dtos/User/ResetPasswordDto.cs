namespace eRezervisi.Common.Dtos.User
{
    public class ResetPasswordDto
    {
        public string Email { get; set; } = null!;
        public string NewPassword { get; set; } = null!;
    }
}
