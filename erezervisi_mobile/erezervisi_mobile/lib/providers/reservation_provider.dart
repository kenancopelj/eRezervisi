import 'dart:convert';

import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/models/requests/reservation/get_reservations_by_status_request.dart';
import 'package:erezervisi_mobile/models/requests/reservation/get_reservations_request.dart';
import 'package:erezervisi_mobile/models/requests/reservation/reservation_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/reservation/reservation_update_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_by_status_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_by_statuses_response.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

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
      Globals.notifier.setInfo("Rezervacija uspješno kreirana", ToastType.Success);
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

  Future<ReservationGetDto> cancel(num reservationId) async {
    String endpoint = "reservations/$reservationId/cancel";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url);

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno otkazano!", ToastType.Success);
      var reservation = ReservationGetDto.fromJson(response.data);
      return reservation;
    }
    throw response;
  }

  Future<ReservationGetDto> confirm(num reservationId) async {
    String endpoint = "reservations/$reservationId/confirm";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url);

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno potvrđeno!", ToastType.Success);
      var reservation = ReservationGetDto.fromJson(response.data);
      return reservation;
    }
    throw response;
  }

  Future<ReservationGetDto> delete(num reservationId) async {
    String endpoint = "reservations/$reservationId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.delete(url);

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno obrisano!", ToastType.Success);
      var reservation = ReservationGetDto.fromJson(response.data);
      return reservation;
    }
    throw response;
  }

  Future<ReservationByStatusesResponse> getByStatus(
      GetReservationsByStatusRequest request) async {
    String endpoint = "reservations/status";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['reservations']
          .map((x) => ReservationByStatusGetDto.fromJson(x))
          .cast<ReservationByStatusGetDto>()
          .toList();

      return ReservationByStatusesResponse(reservations: data);
    }
    throw response;
  }
}
