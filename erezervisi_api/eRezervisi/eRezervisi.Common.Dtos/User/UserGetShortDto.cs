namespace eRezervisi.Common.Dtos.User
{
    public class UserGetShortDto
    {
        public long Id { get; set; }
        public string FullName { get; set; } = null!;
        public string? Image { get; set; }
        public string Initials { get; set; } = null!;
    }
}
