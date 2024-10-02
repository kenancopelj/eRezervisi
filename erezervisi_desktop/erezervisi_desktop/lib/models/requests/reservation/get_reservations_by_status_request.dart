import 'package:erezervisi_desktop/enums/reservation_status.dart';

class GetReservationsByStatusRequest {
  late ReservationStatus status;

  GetReservationsByStatusRequest({
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
    };
  }
}
