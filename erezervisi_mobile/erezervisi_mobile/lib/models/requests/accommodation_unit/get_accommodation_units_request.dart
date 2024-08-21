import 'package:erezervisi_mobile/models/requests/base/base_paged_request.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class GetAccommodationUnitsRequest extends BasePagedRequest {
  num scope = 1;
  num? ownerId;
  num? categoryId;

  GetAccommodationUnitsRequest({
    required super.page,
    required super.pageSize,
    required super.searchTerm,
    required super.orderByColumn,
    required super.orderBy,
  });

  GetAccommodationUnitsRequest.def()
      : super(
            orderBy: Globals.basePagedRequest.orderBy,
            page: Globals.basePagedRequest.page,
            pageSize: Globals.basePagedRequest.pageSize,
            searchTerm: Globals.basePagedRequest.searchTerm,
            orderByColumn: Globals.basePagedRequest.orderByColumn);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();

    data['scope'] = scope;
    data['ownerId'] = ownerId;
    data['categoryId'] = categoryId;

    return data;
  }
}
