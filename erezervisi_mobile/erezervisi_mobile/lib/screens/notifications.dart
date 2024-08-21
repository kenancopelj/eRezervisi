import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:erezervisi_mobile/widgets/my_notifications_custom/new_notification.dart';
import 'package:flutter/material.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Moje obavijesti",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.email_outlined)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Označi sve kao pročitano",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              ),
              NewNotification(),
              NewNotification(),
              NewNotification(),
              NewNotification(),
            ],
          ),
        ),
      ),
    );
  }
}
