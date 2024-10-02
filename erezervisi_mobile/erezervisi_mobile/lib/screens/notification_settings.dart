import 'package:erezervisi_mobile/models/requests/user/update_settings_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_settings_get_dto.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool receiveMails = true;
  bool receiveNotifications = true;

  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();

    loadSettings();
  }

  Future loadSettings() async {
    var response = await userProvider.getById(Globals.loggedUser!.userId);

    setState(() {
      receiveMails = response.settings.receiveMails;
      receiveNotifications = response.settings.receiveNotifications;
    });
  }

  Future updateSettings() async {
    await userProvider.updateSettings(
        Globals.loggedUser!.userId,
        UpdateSettingsDto(
            receiveMails: receiveMails,
            receiveNotifications: receiveNotifications));

    setState(() {
      Globals.enableNotifications = receiveNotifications;
    });
  }

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
                  value: receiveNotifications,
                  onChanged: (value) {
                    setState(() {
                      receiveNotifications = value;
                    });

                    updateSettings();
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
                  value: receiveMails,
                  onChanged: (value) {
                    setState(() {
                      receiveMails = value;
                    });

                    updateSettings();
                  })
            ],
          ),
        ),
      ],
    ));
  }
}
