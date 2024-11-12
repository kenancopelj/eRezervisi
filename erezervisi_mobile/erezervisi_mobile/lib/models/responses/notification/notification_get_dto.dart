import 'package:erezervisi_mobile/enums/notification_status.dart';
import 'package:erezervisi_mobile/enums/notification_type.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_short_dto.dart';

class NotificationGetDto {
  late num userId;
  late UserGetShortDto user;
  late String title;
  String? description;
  late NotificationStatus status;
  late NotificationType type;
  num? accommodationUnitId;
  num? senderId;

  NotificationGetDto({
    required this.userId,
    required this.user,
    required this.title,
    this.description,
    required this.status,
    required this.type,
    this.accommodationUnitId,
    this.senderId,
  });

  factory NotificationGetDto.fromJson(Map<String, dynamic> json) {
    return NotificationGetDto(
      userId: json['userId'] as num,
      user: UserGetShortDto.fromJson(json['user']),
      title: json['title'],
      description: json['description'],
      status: NotificationStatus.values[json['status']],
      type: NotificationType.values[json['type']],
      accommodationUnitId: json['accommodationUnitId'],
      senderId: json['senderId'] as num
    );
  }
}
