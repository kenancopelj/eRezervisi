using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Maintenaces
{
    public class MaintenanceGetDto
    {
        public long Id { get; set; }
        public string Note { get; set; } = null!;
        public long AccommodationUnitId { get; set; }
        public AccommodationUnitGetDto AccommodationUnit { get; set; } = null!;
        public MaintenacePriority Priority { get; set; }
        public MaintenanceStatus Status { get; set; }
    }
}
