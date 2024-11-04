import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/user/update_settings_dto.dart';
import 'package:erezervisi_desktop/providers/user_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late UserProvider userProvider;

  bool receiveEmails = false;
  bool receiveNotifications = false;
  bool markObjectAsUncleanAfterReservation = false;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();

    loadSettings();
  }

  Future loadSettings() async {
    var response = await userProvider.getById(Globals.loggedUser!.userId);

    setState(() {
      receiveEmails = response.settings.receiveEmails;
      receiveNotifications = response.settings.receiveNotifications;
      markObjectAsUncleanAfterReservation = response.settings.receiveNotifications;
    });
  }

  Future updateSettings() async {
    await userProvider.updateSettings(
        Globals.loggedUser!.userId,
        UpdateSettingsDto(
            receiveEmails: receiveEmails,
            receiveNotifications: receiveNotifications,
            markObjectAsUncleanAfterReservation:
                markObjectAsUncleanAfterReservation));

    setState(() {
      Globals.enableNotifications = receiveNotifications;
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Postavke"),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            SizedBox(
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
                      Text('Označi objekat kao Prljav nakon rezervacije'),
                    ],
                  ),
                  Switch(
                      value: markObjectAsUncleanAfterReservation,
                      onChanged: (value) {
                        setState(() {
                          markObjectAsUncleanAfterReservation = value;
                        });
                      })
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Odustani'),
        ),
        ElevatedButton(
          onPressed: () async {
            updateSettings();
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: CustomTheme.bluePrimaryColor,
          ),
          child: const Text('Spremi'),
        ),
      ],
    );
  }
}
