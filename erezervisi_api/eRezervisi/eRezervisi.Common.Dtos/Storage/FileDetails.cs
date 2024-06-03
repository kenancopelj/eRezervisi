namespace eRezervisi.Common.Dtos.Storage
{
    public class FileDetails
    {
        public byte[] Bytes { get; set; } = null!;
        public string FileName { get; set; } = null!;
        public string ContentType { get; set; } = null!;
    }
}
