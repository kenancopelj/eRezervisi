import 'package:erezervisi_desktop/enums/maintenance_priority.dart';
import 'package:erezervisi_desktop/enums/maintenance_status.dart';
import 'package:erezervisi_desktop/models/requests/base/base_paged_request.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class GetMaintenancesRequest extends BasePagedRequest {
  MaintenanceStatus? status;
  MaintenancePriority? priority;

  GetMaintenancesRequest({
    this.status,
    this.priority,
    required super.page,
    required super.pageSize,
    required super.searchTerm,
    required super.orderByColumn,
    required super.orderBy,
  });

  GetMaintenancesRequest.def()
      : super(
            orderBy: Globals.basePagedRequest.orderBy,
            page: Globals.basePagedRequest.page,
            pageSize: Globals.basePagedRequest.pageSize,
            searchTerm: Globals.basePagedRequest.searchTerm,
            orderByColumn: Globals.basePagedRequest.orderByColumn);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return {
      ...data,
      'status': status,
      'priority': priority
    };
  }
}
