import 'package:erezervisi_desktop/enums/reservation_status.dart';

class ReservationGetDto {
  late num id;
  late String code;
  late num guestId;
  late String guest;
  late String guestContact;
  late num accommodationUnitId;
  late String accommodationUnitTitle;
  String? accommodationUnitThumbnailImage;
  late DateTime from;
  late DateTime to;
  late num paymentMethod;
  late num numberOfChildren;
  late num numberOfAdults;
  late num totalPeople;
  late num totalDays;
  late num totalPrice;
  late DateTime createdAt;
  late ReservationStatus status;

  ReservationGetDto({
    required this.id,
    required this.code,
    required this.guestId,
    required this.guest,
    required this.guestContact,
    required this.accommodationUnitId,
    required this.accommodationUnitTitle,
    this.accommodationUnitThumbnailImage,
    required this.from,
    required this.to,
    required this.paymentMethod,
    required this.numberOfChildren,
    required this.numberOfAdults,
    required this.totalPeople,
    required this.totalDays,
    required this.totalPrice,
    required this.createdAt,
    required this.status
  });

  factory ReservationGetDto.fromJson(Map<String, dynamic> json) {
    return ReservationGetDto(
      id: json['id'] as num,
      code: json['code'],
      guestId: json['guestId'] as num,
      guest: json['guest'] as String,
      guestContact: json['guestContact'],
      accommodationUnitId: json['accommodationUnitId'] as num,
      accommodationUnitTitle: json['accommodationUnit']['title'],
      accommodationUnitThumbnailImage: json['accommodationUnit']
          ['thumbnailImage'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      paymentMethod: json['paymentMethod'] as num,
      numberOfChildren: json['numberOfChildren'] as num,
      numberOfAdults: json['numberOfAdults'] as num,
      totalPeople: json['totalPeople'] as num,
      totalDays: json['totalDays'] as num,
      totalPrice: json['totalPrice'] as num,
      createdAt: DateTime.parse(json['createdAt']),
      status: ReservationStatus.values.firstWhere((x) => x.index == json['status'] as num)
    );
  }
}
