using Microsoft.ML.Data;

namespace eRezervisi.Core.Domain.Entities
{
    public class AccommodationUnitRecommendation
    {
        [KeyType(count: 27)]
        public uint AccommodationUnitId { get; set; }
        [KeyType(count: 27)]
        public uint CoAccommodationUnitId { get; set; }
        public float Label { get; set; }
    }
}
