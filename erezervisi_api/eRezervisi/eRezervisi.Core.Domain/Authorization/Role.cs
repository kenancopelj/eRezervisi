using eRezervisi.Core.Domain.Entities;

namespace eRezervisi.Core.Domain.Authorization
{
    public class Role : BaseEntity<long>
    {
        public string Name { get; set; } = null!;
    }
}
