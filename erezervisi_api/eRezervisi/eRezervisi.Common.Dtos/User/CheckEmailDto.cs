namespace eRezervisi.Common.Dtos.User
{
    public class CheckEmailDto
    {
        public long? UserId { get; set; }
        public string Email { get; set; } = null!;
    }
}
