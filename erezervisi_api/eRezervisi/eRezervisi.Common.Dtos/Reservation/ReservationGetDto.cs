﻿using eRezervisi.Common.Dtos.AccommodationUnit;
using eRezervisi.Core.Domain.Enums;

namespace eRezervisi.Common.Dtos.Reservation
{
    public class ReservationGetDto
    {
        public long Id { get; set; }
        public string Code { get; set; } = null!;
        public long GuestId { get; set; }
        public string Guest { get; set; } = null!;
        public string GuestContact { get; set; } = null!;
        public long AccommodationUnitId { get; set; }
        public AccommodationUnitGetDto AccommodationUnit { get; set; } = null!;
        public DateTime From { get; set; }
        public DateTime To { get; set; }
        public PaymentMethod PaymentMethod { get; set; }
        public int NumberOfChildren { get; set; }
        public int NumberOfAdults { get; set; }
        public int TotalPeople { get; set; }
        public int TotalDays { get; set; }
        public double TotalPrice { get; set; }
        public DateTime CreatedAt { get; set; }
        public ReservationStatus Status { get; set; }
    }
}
