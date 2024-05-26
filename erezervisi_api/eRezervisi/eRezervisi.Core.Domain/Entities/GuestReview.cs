namespace eRezervisi.Core.Domain.Entities
{
    public class GuestReview
    {
        public long ReviewId { get; set; }
        public Review Review { get; set; } = null!;
        public long GuestId { get; set; }
        public User Guest { get; set; } = null!;
    }
}