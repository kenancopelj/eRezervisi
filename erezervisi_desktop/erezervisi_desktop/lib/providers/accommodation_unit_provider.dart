import 'dart:convert';

import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/accommodation_unit_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/accommodation_unit_update_dto.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_desktop/models/requests/reviews/get_reviews_request.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class AccommodationUnitProvider extends BaseProvider {
  AccommodationUnitProvider() : super();

  Future<PagedResponse<AccommodationUnitGetDto>> getPaged(
      GetAccommodationUnitsRequest request) async {
    String endpoint = "accommodation-units/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => AccommodationUnitGetDto.fromJson(x))
          .cast<AccommodationUnitGetDto>()
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

  Future<PagedResponse<AccommodationUnitGetDto>> getLatestPaged(
      GetAccommodationUnitsRequest request) async {
    String endpoint = "accommodation-units/latest";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => AccommodationUnitGetDto.fromJson(x))
          .cast<AccommodationUnitGetDto>()
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

  Future<PagedResponse<AccommodationUnitGetDto>> getPopularPaged(
      GetAccommodationUnitsRequest request) async {
    String endpoint = "accommodation-units/popular";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => AccommodationUnitGetDto.fromJson(x))
          .cast<AccommodationUnitGetDto>()
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

  Future<AccommodationUnitGetDto> getById(num id) async {
    String endpoint = "accommodation-units/$id";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var accommodationUnit = AccommodationUnitGetDto.fromJson(response.data);

      return accommodationUnit;
    }
    throw response;
  }

  Future<AccommodationUnitGetDto> create(
      AccommodationUnitCreateDto request) async {
    String endpoint = "accommodation-units";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno kreirano", ToastType.Success);
      var accommodationUnit = AccommodationUnitGetDto.fromJson(response.data);
      return accommodationUnit;
    }
    throw response;
  }

  Future update(AccommodationUnitUpdateDto request) async {
    String endpoint = "accommodation-units/${request.id}";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url, data: request.toJson());

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno ažurirano", ToastType.Success);
      var accommodationUnit = AccommodationUnitGetDto.fromJson(response.data);
      return accommodationUnit;
    }
    throw response;
  }

  Future delete(num id) async {
    String endpoint = "accommodation-units/$id";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.delete(
      url,
    );

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno obrisano", ToastType.Success);
      return;
    }
    throw response;
  }

  Future<PagedResponse<ReviewGetDto>> getReviewsPaged(
      GetReviewsRequest request) async {
    String endpoint = "accommodation-units/reviews";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => ReviewGetDto.fromJson(x))
          .cast<ReviewGetDto>()
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
}
