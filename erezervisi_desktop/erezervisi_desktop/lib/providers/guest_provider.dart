import 'dart:convert';

import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/models/requests/guest/get_guests_request.dart';
import 'package:erezervisi_desktop/models/requests/reviews/review_create_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/guest/guest_get_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class GuestProvider extends BaseProvider {
  GuestProvider() : super();

  Future<PagedResponse<GuestGetDto>> getPaged(GetGuestsRequest request) async {
    String endpoint = "guests/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => GuestGetDto.fromJson(x))
          .cast<GuestGetDto>()
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

  Future createReview(num guestId, ReviewCreateDto request) async {
    String endpoint = "guests/$guestId/review";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      return Globals.notifier.setInfo("Uspješno ažurirnao", ToastType.Success);
    }
    throw response;
  }
}
