import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool allowNotifications = false;
  bool receiveEmails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Obavještenja",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 60,
            )
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.notifications_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Dozvoli obavještenja'),
                ],
              ),
              Switch(
                  value: allowNotifications,
                  onChanged: (value) {
                    setState(() {
                      allowNotifications = value;
                    });
                  })
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.notifications_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Dozvoli e-mail obavijesti'),
                ],
              ),
              Switch(
                  value: receiveEmails,
                  onChanged: (value) {
                    setState(() {
                      receiveEmails = value;
                    });
                  })
            ],
          ),
        ),
      ],
    ));
  }
}
