namespace eRezervisi.Common.Dtos.User
{
    public class CheckForgottenPasswordCodeDto
    {
        public string Email { get; set; } = null!;
        public long Code { get; set; }
    }
}
