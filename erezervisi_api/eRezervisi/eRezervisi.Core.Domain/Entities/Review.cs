namespace eRezervisi.Core.Domain.Entities
{
    public class Review : BaseEntity<long>
    {
        public string Title { get; set; } = null!;
        public double Rating { get; set; }
        public string Note { get; set; } = null!;
    }
}
