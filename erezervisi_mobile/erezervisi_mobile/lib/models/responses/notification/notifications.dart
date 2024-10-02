import 'package:erezervisi_mobile/models/responses/notification/notification_get_dto.dart';

class Notifications {
  late List<NotificationGetDto> notifications;

  Notifications({required this.notifications});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    List<NotificationGetDto> notifications =
        (json['notifications'] as List<NotificationGetDto>)
            .map((notificationJson) => NotificationGetDto.fromJson(json))
            .toList();

    return Notifications(notifications: notifications);
  }
}
