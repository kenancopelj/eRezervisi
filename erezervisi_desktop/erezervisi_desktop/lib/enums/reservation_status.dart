enum ReservationStatus {
  Unknown,
  Draft,
  Confirmed,
  InProgress,
  Declined,
  Cancelled,
  Completed
}

extension ReservationStatusExtension on ReservationStatus {
  String get title {
    switch (this) {
      case ReservationStatus.Draft:
        return "Kreirano";
      case ReservationStatus.Confirmed:
        return "Potvrđeno";
      case ReservationStatus.InProgress:
        return "U toku";
      case ReservationStatus.Declined:
        return "Odbijeno";
      case ReservationStatus.Cancelled:
        return "Otkazano";
      case ReservationStatus.Completed:
        return "Potvrđeno";
      default:
        return "N/A";
    }
  }
}
