import 'package:erezervisi_mobile/screens/notification_settings.dart';
import 'package:erezervisi_mobile/screens/profile.dart';
import 'package:erezervisi_mobile/screens/reset-password.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool allowNotifications = false;
  bool receiveEmails = false;

  navigateToChangePasswordScreen() {
    Navigate.next(
        context,
        AppRoutes.resetPassword.routeName,
        ResetPasswordScreen(
          email: Globals.loggedUser!.email,
          changePassword: true,
        ),
        true);
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
                "Postavke",
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
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: InkWell(
            onTap: () {
              Navigate.next(context, AppRoutes.profile.routeName,
                  const MyProfile(), true);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person_2_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Korisnički nalog'),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: InkWell(
            onTap: () {
              Navigate.next(context, AppRoutes.notificationSettings.routeName,
                  const NotificationSettings(), true);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Obavijesti'),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: InkWell(
            onTap: navigateToChangePasswordScreen,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.lock_outline),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Promijeni lozinku'),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
