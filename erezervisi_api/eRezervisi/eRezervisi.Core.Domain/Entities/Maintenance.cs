using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Core.Domain.Entities
{
    public class Maintenance : BaseEntity<long>
    {
        public long AccommodationUnitId { get; set; }
        public AccommodationUnit AccommodationUnit { get; set; } = null!;
        public MaintenacePriority Priority { get; set; }
        public MaintenanceStatus Status { get; set; }
        public string Note { get; set; } = null!;
    }
}
