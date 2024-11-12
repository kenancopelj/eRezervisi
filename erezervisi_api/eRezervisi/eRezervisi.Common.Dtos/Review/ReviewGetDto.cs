namespace eRezervisi.Common.Dtos.Review
{
    public class ReviewGetDto
    {
        public long Id { get; set; }
        public double Rating { get; set; }
        public string? Note { get; set; }
        public long ReviewerId { get; set; }
        public string Reviewer { get; set; } = null!;
        public string? ReviewerImage { get; set; }
        public double MinutesAgo { get; set; }
        public double HoursAgo { get; set; }
        public double DaysAgo { get; set; }
    }
}
