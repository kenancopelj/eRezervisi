import 'dart:convert';

import 'package:erezervisi_mobile/models/requests/base/base_get_all_request.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_short_dto.dart';
import 'package:erezervisi_mobile/models/responses/search/search_response.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_short_dto.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class SearchProvider extends BaseProvider {
  SearchProvider() : super();

  Future<SearchResponse> get(BaseGetAllRequest request) async {
    String endpoint = "search";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request));

    if (response.statusCode == 200) {
      var users = response.data['users']
          .map((x) => UserGetShortDto.fromJson(x))
          .cast<UserGetShortDto>()
          .toList();

      var accommodationUnits = response.data['accommodationUnits']
          .map((x) => AccommodationUnitGetShortDto.fromJson(x))
          .cast<AccommodationUnitGetShortDto>()
          .toList();

      return SearchResponse(
          accommodationUnits: accommodationUnits, users: users);
    }

    throw response;
  }
}
