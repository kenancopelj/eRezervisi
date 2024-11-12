import 'dart:convert';

import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/accommodation_unit_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_mobile/models/requests/review/review_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/review/get_reviews_response.dart';
import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

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

  Future<List<AccommodationUnitGetDto>> getRecommended(
      num accommodationUnitId) async {
    String endpoint = "accommodation-units/recommend/$accommodationUnitId/";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data
          .map((x) => AccommodationUnitGetDto.fromJson(x))
          .cast<AccommodationUnitGetDto>()
          .toList();
      return data;
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

  Future view(num accommodationUnitId) async {
    String endpoint = "accommodation-units/$accommodationUnitId/view";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url);

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }

  Future<bool> checkIsAllowedToReview(num accommodationUnitId) async {
    String endpoint = "guests/$accommodationUnitId/allowed-review";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return response.data;
    }
    throw response;
  }

  Future<GetReviewsResponse> getAllReviews(num accommodationUnitId) async {
    String endpoint = "accommodation-units/$accommodationUnitId/all-reviews";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data['reviews']
          .map((x) => ReviewGetDto.fromJson(x))
          .cast<ReviewGetDto>()
          .toList();

      var average = response.data['average'] ?? 0;

      return GetReviewsResponse(reviews: data, average: average);
    }
    throw response;
  }

  Future review(num accommodationUnitId, ReviewCreateDto request) async {
    String endpoint = "accommodation-units/$accommodationUnitId/review";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request));

    if (response.statusCode == 200) {
      Globals.notifier
          .setInfo("Recenzija uspješno kreirana", ToastType.Success);
      return;
    }
    throw response;
  }
}
