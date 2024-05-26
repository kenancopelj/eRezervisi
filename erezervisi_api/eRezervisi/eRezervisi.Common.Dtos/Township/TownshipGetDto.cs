using eRezervisi.Common.Dtos.Canton;

namespace eRezervisi.Common.Dtos.Township
{
    public class TownshipGetDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = null!;
        public long CantonId { get; set; }
        public CantonGetDto Canton { get; set; } = null!;
    }
}
