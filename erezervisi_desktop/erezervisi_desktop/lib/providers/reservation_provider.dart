import 'dart:convert';

import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/models/requests/reservation/get_reservations_request.dart';
import 'package:erezervisi_desktop/models/requests/reservation/reservation_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/reservation/reservation_update_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservations_response.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class ReservationProvider extends BaseProvider {
  ReservationProvider() : super();

  Future<PagedResponse<ReservationGetDto>> getPaged(
      GetReservationsRequest request) async {
    String endpoint = "reservations/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => ReservationGetDto.fromJson(x))
          .cast<ReservationGetDto>()
          .toList();

      var pagedResponse = PagedResponse.fromJson(response.data);

      return PagedResponse(
          totalItems: pagedResponse.totalItems,
          totalPages: pagedResponse.totalPages,
          pageSize: pagedResponse.pageSize,
          items: data);
    }
    throw response;
  }

  Future<ReservationsResponse> getCalendar(
      GetReservationsRequest request) async {
    String endpoint = "reservations/calendar";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['reservations']
          .map((x) => ReservationGetDto.fromJson(x))
          .cast<ReservationGetDto>()
          .toList();

      return ReservationsResponse(reservations: data);
    }
    throw response;
  }

  Future<ReservationGetDto> getById(num id) async {
    String endpoint = "reservations/$id";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var reservation = ReservationGetDto.fromJson(response.data);

      return reservation;
    }
    throw response;
  }

  Future<ReservationGetDto> create(ReservationCreateDto request) async {
    String endpoint = "reservations";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno kreirano", ToastType.Success);
      var reservation = ReservationGetDto.fromJson(response.data);
      return reservation;
    }
    throw response;
  }

  Future<ReservationGetDto> update(ReservationUpdateDto request) async {
    String endpoint = "reservations";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url);

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno ažurirano", ToastType.Success);
      var reservation = ReservationGetDto.fromJson(response.data);
      return reservation;
    }
    throw response;
  }

  Future decline(num reservationId) async {
    String endpoint = "reservations/$reservationId/decline";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url);

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno odbijeno!", ToastType.Success);
      return;
    }
    throw response;
  }
}
