import 'dart:convert';

import 'package:erezervisi_mobile/models/requests/townshp/get_all_townships_request.dart';
import 'package:erezervisi_mobile/models/requests/townshp/get_townships_request.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/township/township_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/township/townships.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class TownshipProvider extends BaseProvider {
  TownshipProvider() : super();

  Future<PagedResponse<TownshipGetDto>> getPaged(
      GetTownshipsRequest request) async {
    String endpoint = "townships/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => TownshipGetDto.fromJson(x))
          .cast<TownshipGetDto>()
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

  Future<Townships> getAll(GetAllTownshipsRequest request) async {
    String endpoint = "townships";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['townships']
          .map((x) => TownshipGetDto.fromJson(x))
          .cast<TownshipGetDto>()
          .toList();

      return Townships(townships: data);
    }
    throw response;
  }
}
