import 'package:erezervisi_desktop/models/responses/notification/notification_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/notification/notifications.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class NotificationProvider extends BaseProvider {
  NotificationProvider() : super();

  Future<Notifications> getAll() async {
    String endpoint = "notifications";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data['notifications']
          .map((x) => NotificationGetDto.fromJson(x))
          .cast<NotificationGetDto>()
          .toList();

      return Notifications(notifications: data);
    }
    throw response;
  }

  Future markAsRead() async {
    String endpoint = "notifications/mark-as-read";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.put(url);

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}
