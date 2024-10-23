import 'package:erezervisi_desktop/enums/notification_status.dart';
import 'package:erezervisi_desktop/enums/notification_type.dart';
import 'package:erezervisi_desktop/helpers/file_helper.dart';
import 'package:erezervisi_desktop/models/responses/notification/notification_get_dto.dart';
import 'package:erezervisi_desktop/providers/file_provider.dart';
import 'package:erezervisi_desktop/screens/chat/chat.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewNotification extends StatefulWidget {
  final NotificationGetDto notification;
  const NewNotification({super.key, required this.notification});

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  late FileProvider fileProvider;

  XFile? image;

  @override
  void initState() {
    super.initState();

    fileProvider = context.read<FileProvider>();

    if (widget.notification.type == NotificationType.Message) {
      loadImage(widget.notification.user.image);
    }
  }

  Future loadImage(String? fileName) async {
    if (fileName != null && fileName.trim().isEmpty) return;

    try {
      var response = await fileProvider.downloadUserImage(fileName!);
      var xfile = await getXFileFromBytes(response.bytes, response.fileName);

      setState(() {
        image = xfile;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleClick,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        height: 75,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[100]),
              child: notificationIcon(),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10, top: 15),
                width: MediaQuery.of(context).size.width - 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notification.title,
                      style: TextStyle(
                          fontWeight: widget.notification.status ==
                                  NotificationStatus.Unread
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.notification.description ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  handleClick() {
    var notification = widget.notification;
    switch (notification.type) {
      case NotificationType.AccommodationUnit:
      case NotificationType.Message:
        Navigate.next(context, AppRoutes.chat.routeName, const MyChat(), true);
        break;
      default:
        return;
    }
  }

  Widget notificationIcon() {
    Color iconColor = Colors.grey[600]!;
    switch (widget.notification.type) {
      case NotificationType.Message:
        return Icon(
          Icons.person,
          color: iconColor,
        );
      case NotificationType.AccommodationUnit:
        return Icon(
          Icons.bed_outlined,
          color: iconColor,
        );
      default:
        return Icon(Icons.settings_outlined, color: iconColor);
    }
  }
}
