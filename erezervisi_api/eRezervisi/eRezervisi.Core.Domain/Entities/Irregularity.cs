using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Domain.Entities
{
    public class Irregularity : BaseEntity<long>
    {
        public long AccommodationUnitId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
        public IrregularityStatus Status { get; set; }
        public string? File { get; set; }
    }
}
