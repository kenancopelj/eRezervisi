import 'package:erezervisi_mobile/models/requests/canton/get_all_cantons_request.dart';
import 'package:erezervisi_mobile/models/responses/canton/canton_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/canton/cantons.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class CantonProvider extends BaseProvider {
  CantonProvider() : super();

  Future<Cantons> getAll(GetAllCantonsRequest request) async {
    String endpoint = "cantons";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['cantons']
          .map((x) => CantonGetDto.fromJson(x))
          .cast<CantonGetDto>()
          .toList();

      return Cantons(cantons: data);
    }
    throw response;
  }
}
