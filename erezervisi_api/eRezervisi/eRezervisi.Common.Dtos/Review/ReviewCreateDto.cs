namespace eRezervisi.Common.Dtos.Review
{
    public class ReviewCreateDto
    {
        public string Title { get; set; } = null!;
        public string Note { get; set; } = null!;
        public double Rating { get; set; }
    }
}
