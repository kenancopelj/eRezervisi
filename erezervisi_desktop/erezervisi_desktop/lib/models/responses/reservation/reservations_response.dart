import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';

class ReservationsResponse {
  late List<ReservationGetDto> reservations;

  ReservationsResponse({required this.reservations});

  factory ReservationsResponse.fromJson(Map<String, dynamic> json) {
    List<ReservationGetDto> reservations =
        (json['reservations'] as List<ReservationGetDto>)
            .map((messageJson) => ReservationGetDto.fromJson(json))
            .toList();

    return ReservationsResponse(reservations: reservations);
  }
}
