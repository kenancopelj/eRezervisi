namespace eRezervisi.Core.Domain.Entities
{
    public class Township : BaseEntity<long>
    {
        public string Title { get; set; } = null!;
        public long CantonId { get; set; }
        public Canton Canton { get; set; } = null!;
    }
}
