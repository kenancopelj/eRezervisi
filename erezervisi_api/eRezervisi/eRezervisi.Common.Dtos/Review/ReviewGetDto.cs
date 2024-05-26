namespace eRezervisi.Common.Dtos.Review
{
    public class ReviewGetDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = null!;
        public double Rating { get; set; }
        public string Note { get; set; } = null!;
        public long ReviewerId { get; set; }
        public string Reviewer { get; set; } = null!;
    }
}
