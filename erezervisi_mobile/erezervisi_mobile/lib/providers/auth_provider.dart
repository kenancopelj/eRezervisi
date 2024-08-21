import 'package:erezervisi_mobile/models/requests/auth/auth_dto.dart';
import 'package:erezervisi_mobile/models/responses/auth/jwt_token_response.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class AuthProvider extends BaseProvider {
  AuthProvider() : super();

  Future<JwtTokenResponse> login(AuthDto authDto) async {
    String endpoint = "authentication/sign-in";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: authDto.toJson());

    if (response.statusCode == 200) {
      return JwtTokenResponse.fromJson(response.data);
    }
    throw response;
  }

  Future<JwtTokenResponse> refreshToken(String token) async {
    String endpoint = "authentication/refresh";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url, data: token);

    if (response.statusCode == 200) {
      return JwtTokenResponse.fromJson(response.data);
    } else {
      throw Exception(response);
    }
  }
}
