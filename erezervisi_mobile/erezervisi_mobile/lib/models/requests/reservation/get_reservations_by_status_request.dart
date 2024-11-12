import 'package:erezervisi_mobile/enums/reservation_status.dart';

class GetReservationsByStatusRequest {
  ReservationStatus? status;

  GetReservationsByStatusRequest({
    this.status,
  });

  GetReservationsByStatusRequest.def();


  Map<String, dynamic> toJson() {
    return {
      'status': status?.index,
    };
  }
}
