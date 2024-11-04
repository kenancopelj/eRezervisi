import 'package:erezervisi_desktop/constants/topics.dart';
import 'package:erezervisi_desktop/models/responses/notification/notifications.dart';
import 'package:erezervisi_desktop/providers/notification_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/my_notifications_custom/new_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  late NotificationProvider notificationProvider;

  Notifications notifications = Notifications(notifications: []);

  Future runSignalR() async {
    final connection = HubConnectionBuilder()
        .withUrl("${Globals.apiUrl}notification-hub",
            options: HttpConnectionOptions(
              accessTokenFactory: () async => Globals.loggedUser!.token,
            ))
        .build();

    await connection.start();

    connection.on('${Topics.notification}#${Globals.loggedUser!.userId}',
        (arguments) {
      loadNotifications();
    });
  }

  Future loadNotifications() async {
    var response = await notificationProvider.getAll();

    if (mounted) {
      setState(() {
        notifications = response;
      });
    }
  }

  Future markAsRead() async {
    await notificationProvider.markAsRead();
    await loadNotifications();
  }

  @override
  void initState() {
    super.initState();

    notificationProvider = context.read<NotificationProvider>();

    if (Globals.enableNotifications) {
      runSignalR();
    }

    loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left:30),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Moje obavijesti",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: markAsRead,
                        icon: const Icon(Icons.email_outlined)),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Označi sve kao pročitano",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              ),
              notifications.notifications.isEmpty
                  ? Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.3),
                      child: Text("Nema novih obavještenja"),
                    )
                  : Column(
                      children: notifications.notifications
                          .map((notification) =>
                              NewNotification(notification: notification))
                          .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
