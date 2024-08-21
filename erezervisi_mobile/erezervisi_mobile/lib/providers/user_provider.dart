import 'package:erezervisi_mobile/models/requests/user/user_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_by_status_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/review/get_reviews_response.dart';
import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

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

  Future getById(num id) async {
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
}
