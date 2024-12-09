class GetRevenueDto {
  late num totalNumberOfReservations;
  late num averageReservationPrice;
  late num revenueThisMonth;
  late num revenueLastMonth;
  late num totalRevenue;

  GetRevenueDto({
    required this.totalNumberOfReservations,
    required this.averageReservationPrice,
    required this.revenueThisMonth,
    required this.revenueLastMonth,
    required this.totalRevenue,
  });

  GetRevenueDto.def();

  factory GetRevenueDto.fromJson(Map<String, dynamic> json) {
    return GetRevenueDto(
      totalNumberOfReservations: json['totalNumberOfReservations'] as num,
      averageReservationPrice: json['averageReservationPrice'] as num,
      revenueThisMonth: json['revenueThisMonth'] as num,
      revenueLastMonth: json['revenueLastMonth'] as num,
      totalRevenue: json['totalRevenue'] as num,
    );
  }
}
