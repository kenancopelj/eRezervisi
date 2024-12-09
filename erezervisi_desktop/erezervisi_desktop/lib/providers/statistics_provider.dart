import 'dart:convert';

import 'package:erezervisi_desktop/models/requests/statistics/get_guests_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/requests/statistics/get_reservations_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_guests_by_year_dto.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_reservations_by_year_dto.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_revenue_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class StatisticsProvider extends BaseProvider {
  StatisticsProvider() : super();

  Future<List<GetReservationsByYearDto>> getReservationsByYear(
      GetReservationsYearOrMonthRequest request) async {
    String endpoint = "statistics/reservations-monthly";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data
          .map((x) => GetReservationsByYearDto.fromJson(x))
          .cast<GetReservationsByYearDto>()
          .toList();

      return data;
    }
    throw response;
  }

  Future<List<GetGuestsByYearDto>> getGuestsByYear(
      GetGuestsYearOrMonthRequest request) async {
    String endpoint = "statistics/guests-monthly";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data
          .map((x) => GetGuestsByYearDto.fromJson(x))
          .cast<GetGuestsByYearDto>()
          .toList();

      return data;
    }
    throw response;
  }

  Future<GetRevenueDto> getRevenue() async {
    String endpoint = "statistics/revenue";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = GetRevenueDto.fromJson(response.data);
      return data;
    }
    throw response;
  }
}
