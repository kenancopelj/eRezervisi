namespace eRezervisi.Core.Domain.Exceptions
{
    public class DomainException : Exception
    {
        public string Code { get; set; }
        public Dictionary<string, object>? Payload { get; private set; }

        public DomainException(string code, string message) : base(message)
        {
            Code = code;
        }

        public DomainException(string code, string message, Dictionary<string, object> payload) : base(message)
        {
            Code = code;
            Payload = payload;
        }
    }
}
