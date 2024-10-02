import 'dart:convert';

import 'package:erezervisi_desktop/models/requests/favorites/get_favorites_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/favorites/favorite_get_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class FavoritesProvider extends BaseProvider {
  FavoritesProvider() : super();

  Future<FavoriteGetDto> add(num accommodationUnitId) async {
    String endpoint = "favorites/$accommodationUnitId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url);

    if (response.statusCode == 200) {
      return FavoriteGetDto.fromJson(response.data);
    }
    throw response;
  }

  Future remove(num accommodationUnitId) async {
    String endpoint = "favorites/$accommodationUnitId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.delete(url);

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }

  Future<PagedResponse<FavoriteGetDto>> getPaged(
      GetFavoritesRequest request) async {
    String endpoint = "favorites/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => FavoriteGetDto.fromJson(x))
          .cast<FavoriteGetDto>()
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
