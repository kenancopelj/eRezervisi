import 'package:erezervisi_desktop/models/responses/reservation/reservation_by_status_get_dto.dart';

class ReservationByStatusesResponse {
  late List<ReservationByStatusGetDto> reservations;

  ReservationByStatusesResponse({required this.reservations});

  factory ReservationByStatusesResponse.fromJson(Map<String, dynamic> json) {
    List<ReservationByStatusGetDto> reservations =
        (json['reservations'] as List<ReservationByStatusGetDto>)
            .map((reservationJson) => ReservationByStatusGetDto.fromJson(json))
            .toList();

    return ReservationByStatusesResponse(reservations: reservations);
  }
}
