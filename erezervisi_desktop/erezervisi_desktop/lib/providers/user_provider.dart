import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/models/requests/user/update_settings_dto.dart';
import 'package:erezervisi_desktop/models/requests/user/user_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/user/user_update_dto.dart';
import 'package:erezervisi_desktop/models/responses/review/get_reviews_response.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/user/check_code_dto.dart';
import 'package:erezervisi_desktop/models/responses/user/request_code_dto.dart';
import 'package:erezervisi_desktop/models/responses/user/reset_password_dto.dart';
import 'package:erezervisi_desktop/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/user/user_settings_get_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class UserProvider extends BaseProvider {
  UserProvider() : super();

  Future create(UserCreateDto request) async {
    String endpoint = "users/register";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return UserGetDto.fromJson(response.data);
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

  Future<GetReviewsResponse> getMyReviews() async {
    String endpoint = "users/my-reviews";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data['reviews']
          .map((x) => ReviewGetDto.fromJson(x))
          .cast<ReviewGetDto>()
          .toList();

      return GetReviewsResponse(reviews: data);
    }
    throw response;
  }

  Future<UserSettingsGetDto> updateSettings(
      num userId, UpdateSettingsDto request) async {
    String endpoint = "users/$userId/change-settings";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url, data: request.toJson());

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno ažurirano", ToastType.Success);
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
      Globals.notifier.setInfo("Lozinka uspješno resetovana", ToastType.Success);
      return true;
    }
    throw response;
  }
}
