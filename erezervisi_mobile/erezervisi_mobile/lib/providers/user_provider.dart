import 'dart:convert';

import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/models/requests/review/get_users_reviews_request.dart';
import 'package:erezervisi_mobile/models/requests/user/update_settings_dto.dart';
import 'package:erezervisi_mobile/models/requests/user/user_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/user/user_update_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_code_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_email_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_phone_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_username_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/request_code_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/reset_password_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_settings_get_dto.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class UserProvider extends BaseProvider {
  UserProvider() : super();

  Future create(UserCreateDto request) async {
    String endpoint = "users/register";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješna registracija", ToastType.Success);
      return;
    }
    throw response;
  }

  Future update(num userId, UserUpdateDto request) async {
    String endpoint = "users/$userId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url, data: request.toJson());

    if (response.statusCode == 200) {
      return UserGetDto.fromJson(response.data);
    }
    throw response;
  }

  Future<UserGetDto> getById(num id) async {
    String endpoint = "users/$id";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return UserGetDto.fromJson(response.data);
    }

    throw response;
  }

  Future<PagedResponse<ReviewGetDto>> getMyReviewsPaged(
      GetUsersReviewsRequest request) async {
    String endpoint = "users/reviews/paged";
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

  Future<UserSettingsGetDto> updateSettings(
      num userId, UpdateSettingsDto request) async {
    String endpoint = "users/$userId/change-settings";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url, data: request.toJson());

    if (response.statusCode == 200) {
      return UserSettingsGetDto.fromJson(response.data);
    }
    throw response;
  }

  Future<bool> requestForgottenPasswordCode(RequestCodeDto request) async {
    String endpoint = "users/request-forgotten-password-code";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return true;
    }
    throw response;
  }

  Future<bool> checkForgottenPasswordCode(CheckCodeDto request) async {
    String endpoint = "users/check-forgotten-password-code";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return true;
    }
    throw response;
  }

  Future<bool> resetPassword(ResetPasswordDto request) async {
    String endpoint = "users/reset-password";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return true;
    }
    throw response;
  }

  Future<bool> checkUsername(CheckUsernameDto request) async {
    String endpoint = "users/check-username";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return response.data;
    }
    return true;
  }

  Future<bool> checkEmail(CheckEmailDto request) async {
    String endpoint = "users/check-email";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return response.data;
    }
    return true;
  }

  Future<bool> checkPhoneNumber(CheckPhoneDto request) async {
    String endpoint = "users/check-phone-number";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return response.data;
    }
    return true;
  }
}
