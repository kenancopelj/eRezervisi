class ReservationByStatusGetDto {
  late num id;
  late String code;
  late String accommodationUnit;
  late DateTime from;
  late DateTime to;
  late num totalPeople;
  late num totalDays;
  late num totalPrice;
  late DateTime createdAt;

  ReservationByStatusGetDto({
    required this.id,
    required this.code,
    required this.accommodationUnit,
    required this.from,
    required this.to,
    required this.totalPeople,
    required this.totalDays,
    required this.totalPrice,
    required this.createdAt,
  });

  factory ReservationByStatusGetDto.fromJson(Map<String, dynamic> json) {
    return ReservationByStatusGetDto(
      id: json['id'] as num,
      code: json['code'],
      accommodationUnit: json['accommodationUnit'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      totalPeople: json['totalPeople'] as num,
      totalDays: json['totalDays'] as num,
      totalPrice: json['totalPrice'] as num,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
