class GetReservationsByYearDto {
  late num month;
  late num totalReservations;

  GetReservationsByYearDto(
      {required this.month, required this.totalReservations});

  factory GetReservationsByYearDto.fromJson(Map<String, dynamic> json) {
    return GetReservationsByYearDto(
        month: json['month'] as num,
        totalReservations: json['totalReservations'] as num);
  }
}
