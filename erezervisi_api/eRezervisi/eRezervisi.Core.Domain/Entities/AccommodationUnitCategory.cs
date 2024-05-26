namespace eRezervisi.Core.Domain.Entities
{
    public class AccommodationUnitCategory : BaseEntity<long>
    {
        public string Title { get; set; } = null!;
        public string ShortTitle { get; set; } = null!;
    }
}
