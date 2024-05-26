namespace eRezervisi.Core.Domain
{
    public interface IBaseEntity<T> : IAuditable
    {
        T Id { get; }
    }

    public interface IAuditable
    {
        DateTime CreatedAt { get; set; }
        long CreatedBy { get; set; }
        DateTime ModifiedAt { get; set; }

        long ModifiedBy { get; set; }
        DateTime? DeletedAt { get; set; }
        long? DeletedBy { get; set; }
        bool Deleted { get; set; }
    }
}
