import 'package:erezervisi_desktop/enums/maintenance_priority.dart';
import 'package:erezervisi_desktop/enums/maintenance_status.dart';

class MaintenanceGetDto {
  late num id;
  late String note;
  late num accommodationUnitId;
  late String accommodationUnitTitle;
  late MaintenanceStatus status;
  late MaintenancePriority priority;

  MaintenanceGetDto(
      {required this.id,
      required this.note,
      required this.accommodationUnitId,
      required this.accommodationUnitTitle,
      required this.status,
      required this.priority});

  factory MaintenanceGetDto.fromJson(Map<String, dynamic> json) {
    return MaintenanceGetDto(
        id: json['id'] as num,
        note: json['note'],
        accommodationUnitId: json['accommodationUnitId'],
        accommodationUnitTitle: json['accommodationUnit']['title'],
        status: MaintenanceStatus.values
            .where((item) => item == json['status'])
            .first,
        priority: MaintenancePriority.values
            .where((item) => item == json['priority'])
            .first);
  }
}
