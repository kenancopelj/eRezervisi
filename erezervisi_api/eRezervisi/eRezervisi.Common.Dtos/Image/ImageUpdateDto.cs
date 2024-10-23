namespace eRezervisi.Common.Dtos.Image
{
    public class ImageUpdateDto
    {
        public long? Id { get; set; }
        public string? ImageBase64 { get; set; }
        public string? ImageFileName { get; set; }
        public bool? IsThumbnail { get; set; }
        public bool Delete { get; set; }
    }
}
