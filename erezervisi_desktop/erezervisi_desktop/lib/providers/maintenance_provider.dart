import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/models/requests/maintenance/get_maintenances_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/maintenance/maintenance_get_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class MaintenanceProvider extends BaseProvider {
  MaintenanceProvider() : super();

  Future<PagedResponse<MaintenanceGetDto>> getPaged(
      GetMaintenancesRequest request) async {
    String endpoint = "maintenances/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => MaintenanceGetDto.fromJson(x))
          .cast<MaintenanceGetDto>()
          .toList();
      var pagedResponse = PagedResponse.fromJson(response.data);

      return PagedResponse(
          totalItems: pagedResponse.totalItems,
          totalPages: pagedResponse.totalPages,
          pageSize: pagedResponse.pageSize,
          items: data);
    } else {
      throw Exception(response);
    }
  }

  Future markAsCompleted(num maintenanceId) async {
    String endpoint = "maintenances/$maintenanceId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url);

    if (response.statusCode == 200) {
      Globals.notifier.setInfo("Uspješno ažurirano", ToastType.Success);
      return;
    }

    throw response;
  }

  Future<MaintenanceGetDto> getById(num maintenanceId) async {
    String endpoint = "maintenances/$maintenanceId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return MaintenanceGetDto.fromJson(response.data);
    }

    throw response;
  }

}
