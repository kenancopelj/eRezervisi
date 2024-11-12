namespace eRezervisi.Core.Domain.Entities
{
    public class Review : BaseEntity<long>
    {
        public double Rating { get; set; }
        public string? Note { get; set; }
    }
}
