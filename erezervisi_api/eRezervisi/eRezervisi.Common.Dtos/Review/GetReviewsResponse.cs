namespace eRezervisi.Common.Dtos.Review
{
    public class GetReviewsResponse
    {
        public List<ReviewGetDto> Reviews { get; set; } = null!;
        public double Average { get; set; }
    }
}
