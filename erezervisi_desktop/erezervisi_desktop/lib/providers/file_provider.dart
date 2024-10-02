import 'package:erezervisi_desktop/models/responses/storage/file_details.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class FileProvider extends BaseProvider {
  FileProvider() : super();

  Future<FileDetails> downloadAccommodationUnitImage(String fileName) async {
    String endpoint = "files/download-accommodation-unit-logo/$fileName";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return FileDetails.fromJson(response.data);
    }
    throw response;
  }

  Future<FileDetails> downloadUserImage(String fileName) async {
    String endpoint = "files/download-user-logo/$fileName";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return FileDetails.fromJson(response.data);
    }
    throw response;
  }
}
