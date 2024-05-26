namespace eRezervisi.Core.Domain.Entities
{
    public class Township : BaseEntity<long>
    {
        public string Title { get; set; } = null!;
        public string PostCode { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public long CantonId { get; set; }
        public Canton Canton { get; set; } = null!;
    }
}
