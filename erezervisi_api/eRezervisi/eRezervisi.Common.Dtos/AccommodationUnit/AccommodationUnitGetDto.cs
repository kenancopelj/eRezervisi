﻿using eRezervisi.Common.Dtos.AccommodationUnitCategories;
using eRezervisi.Common.Dtos.AccommodationUnitPolicy;
using eRezervisi.Common.Dtos.Image;
using eRezervisi.Common.Dtos.Township;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.AccommodationUnit
{
    public class AccommodationUnitGetDto
    {
        public long Id { get; set; }
        public string Title { get; set; } = null!;
        public string Address { get; set; } = null!;
        public double Price { get; set; }
        public string? Note { get; set; }
        public long OwnerId { get; set; }
        public PolicyGetDto AccommodationUnitPolicy { get; set; } = null!;
        public long AccommodationUnitCategoryId { get; set; }
        public CategoryGetDto AccommodationUnitCategory { get; set; } = null!;
        public long TownshipId { get; set; }
        public TownshipGetDto Township { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public double TapPosition { get; set; }
        public string ThumbnailImage { get; set; } = null!;
        public List<ImageGetDto> Images { get; set; } = new();
        public bool Favorite { get; set; }
        public double? AverageRating { get; set; }
        public AccommodationUnitStatus Status { get; set; }
    }
}
