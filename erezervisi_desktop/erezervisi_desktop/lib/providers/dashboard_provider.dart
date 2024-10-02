import 'package:erezervisi_desktop/models/requests/dashboard/get_dashboard_data_request.dart';
import 'package:erezervisi_desktop/models/responses/dashboard/dashboard_data_response.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class DashboardProvider extends BaseProvider {
  DashboardProvider() : super();

  Future<DashboardDataResponse> get(GetDashboardDataRequest request) async {
    String endpoint = "dashboard";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return DashboardDataResponse.fromJson(response.data);
    }
    throw response;
  }
}
