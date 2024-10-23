namespace eRezervisi.Common.Dtos.Guest
{
    public class GuestGetDto
    {
        public long Id { get; set; }
        public string FullName { get; set; } = null!;
        public string Phone { get; set; } = null!;
        public string Email { get; set; } = null!;
    }
}
