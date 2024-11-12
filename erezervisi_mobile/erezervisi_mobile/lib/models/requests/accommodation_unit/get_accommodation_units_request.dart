import 'package:erezervisi_mobile/enums/scope_type.dart';
import 'package:erezervisi_mobile/models/requests/base/base_paged_request.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class GetAccommodationUnitsRequest extends BasePagedRequest {
  num scope = ScopeType.Mobile.index;
  num? categoryId;
  num? status;
  num? capacity;
  bool? withPool;
  bool? birthdayPartiesAllowed;
  bool? alcoholAllowed;
  bool? oneNightOnly;
  num? cantonId;
  num? townshipId;

  GetAccommodationUnitsRequest(
      {required super.page,
      required super.pageSize,
      required super.searchTerm,
      required super.orderByColumn,
      required super.orderBy,
      this.capacity,
      this.birthdayPartiesAllowed,
      this.alcoholAllowed,
      this.oneNightOnly,
      this.cantonId,
      this.townshipId});

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
    data['categoryId'] = categoryId;
    data['capacity'] = capacity;
    data['birthdayPartiesAllowed'] = birthdayPartiesAllowed;
    data['alcoholAllowed'] = alcoholAllowed;
    data['oneNightOnly'] = oneNightOnly;
    data['withPool'] = withPool;
    data['cantonId'] = cantonId;
    data['townshipId'] = townshipId;

    return data;
  }
}
