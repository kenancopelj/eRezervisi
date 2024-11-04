class ReservationGetShortDto {
  late num id;
  late String guest;
  late String accommodationUnit;
  String? guestImage;
  late DateTime from;
  late DateTime to;
  late num totalPrice;

  ReservationGetShortDto({
    required this.id,
    required this.accommodationUnit,
    required this.guest,
    this.guestImage,
    required this.from,
    required this.to,
    required this.totalPrice,
  });

  factory ReservationGetShortDto.fromJson(Map<String, dynamic> json) {
    return ReservationGetShortDto(
      id: json['id'] as num,
      guest: json['guest'],
      accommodationUnit: json['accommodationUnit'],
      guestImage: json['guestImage'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      totalPrice: json['totalPrice'] as num,
    );
  }
}
