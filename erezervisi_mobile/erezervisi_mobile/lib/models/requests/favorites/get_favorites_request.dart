import 'package:erezervisi_mobile/models/requests/base/base_paged_request.dart';

class GetFavoritesRequest extends BasePagedRequest {
  GetFavoritesRequest(
      {required super.page,
      required super.pageSize,
      required super.searchTerm,
      required super.orderByColumn,
      required super.orderBy});
}
