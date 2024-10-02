import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';

class ReservationGetDto {
  late num id;
  late String code;
  late num guestId;
  late String guest;
  late num accommodationUnitId;
  late AccommodationUnitGetDto accommodationUnit;
  late DateTime from;
  late DateTime to;
  late num paymentMethod;
  late num numberOfChildren;
  late num numberOfAdults;
  late num totalPeople;
  late num totalDays;
  late num totalPrice;
  late DateTime createdAt;

  ReservationGetDto({
    required this.id,
    required this.code,
    required this.guestId,
    required this.guest,
    required this.accommodationUnitId,
    required this.accommodationUnit,
    required this.from,
    required this.to,
    required this.paymentMethod,
    required this.numberOfChildren,
    required this.numberOfAdults,
    required this.totalPeople,
    required this.totalDays,
    required this.totalPrice,
    required this.createdAt,
  });

  factory ReservationGetDto.fromJson(Map<String, dynamic> json) {
    return ReservationGetDto(
      id: json['id'] as num,
      code: json['code'],
      guestId: json['guestId'] as num,
      guest: json['guest'] as String,
      accommodationUnitId: json['accommodationUnitId'] as num,
      accommodationUnit:
          AccommodationUnitGetDto.fromJson(json['accommodationUnit']),
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      paymentMethod: json['paymentMethod'] as num,
      numberOfChildren: json['numberOfChildren'] as num,
      numberOfAdults: json['numberOfAdults'] as num,
      totalPeople: json['totalPeople'] as num,
      totalDays: json['totalDays'] as num,
      totalPrice: json['totalPrice'] as num,
      createdAt: json['createdAt'] as DateTime,
    );
  }
}
