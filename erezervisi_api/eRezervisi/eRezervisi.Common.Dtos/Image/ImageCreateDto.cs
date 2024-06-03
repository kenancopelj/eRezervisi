namespace eRezervisi.Common.Dtos.Image
{
    public class ImageCreateDto
    {
        public string ImageBase64 { get; set; } = null!;
        public string ImageFileName { get; set; } = null!;
        public bool IsThumbnail { get; set; }
    }
}
