import 'package:erezervisi_mobile/models/requests/base/base_paged_request.dart';

class GetCategoriesRequest extends BasePagedRequest {
  GetCategoriesRequest(
      {required super.page,
      required super.pageSize,
      required super.searchTerm,
      required super.orderByColumn,
      required super.orderBy});
}
