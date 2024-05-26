namespace eRezervisi.Core.Domain
{
    public class BaseEntity<T> : IBaseEntity<T> where T : struct
    {
        public T Id { get; set; }

        public DateTime CreatedAt { get; set; }
        public long CreatedBy { get; set; }
        public DateTime ModifiedAt { get; set; }
        public long ModifiedBy { get; set; }
        public bool Deleted { get; set; }
        public DateTime? DeletedAt { get; set; }
        public long? DeletedBy { get; set; }
    }
}
