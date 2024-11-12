import 'package:erezervisi_desktop/models/responses/dashboard/dashboard_data_response.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class DashboardProvider extends BaseProvider {
  DashboardProvider() : super();

  Future<DashboardDataResponse> get() async {
    String endpoint = "dashboard";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return DashboardDataResponse.fromJson(response.data);
    }
    throw response;
  }
}
