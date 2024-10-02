import 'package:erezervisi_desktop/models/requests/base/base_paged_request.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class GetCategoriesRequest extends BasePagedRequest {
  GetCategoriesRequest(
      {required super.page,
      required super.pageSize,
      required super.searchTerm,
      required super.orderByColumn,
      required super.orderBy});

  GetCategoriesRequest.def()
      : super(
            orderBy: Globals.basePagedRequest.orderBy,
            page: Globals.basePagedRequest.page,
            pageSize: Globals.basePagedRequest.pageSize,
            searchTerm: Globals.basePagedRequest.searchTerm,
            orderByColumn: Globals.basePagedRequest.orderByColumn);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
