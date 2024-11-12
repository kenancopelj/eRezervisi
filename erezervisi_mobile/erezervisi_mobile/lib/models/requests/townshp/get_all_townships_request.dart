import 'package:erezervisi_mobile/models/requests/base/base_get_all_request.dart';

class GetAllTownshipsRequest extends BaseGetAllRequest {
  num? cantonId;

  GetAllTownshipsRequest({required super.searchTerm, this.cantonId});

  @override
  Map<String, dynamic> toJson() {
    var data = super.toJson();

    data['cantonId'] = cantonId;

    return data;
  }
}
