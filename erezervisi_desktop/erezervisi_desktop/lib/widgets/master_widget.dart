import 'dart:io';
import 'package:erezervisi_desktop/constants/topics.dart';
import 'package:erezervisi_desktop/enums/notification_status.dart';
import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/main.dart';
import 'package:erezervisi_desktop/models/responses/notification/notifications.dart';
import 'package:erezervisi_desktop/providers/notification_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/accommodation_units.dart';
import 'package:erezervisi_desktop/screens/chat/chat.dart';
import 'package:erezervisi_desktop/screens/guests/guests.dart';
import 'package:erezervisi_desktop/screens/home.dart';
import 'package:erezervisi_desktop/screens/maintenances/maintenances.dart';
import 'package:erezervisi_desktop/screens/notifications.dart';
import 'package:erezervisi_desktop/screens/reservations/reservations.dart';
import 'package:erezervisi_desktop/screens/reviews/reviews.dart';
import 'package:erezervisi_desktop/screens/statistics/statistics.dart';
import 'package:erezervisi_desktop/shared/components/loader.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/widgets/settings.dart';
import 'package:erezervisi_desktop/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class MasterWidget extends StatefulWidget {
  final Widget child;
  final bool isLogin;
  const MasterWidget({super.key, required this.child, this.isLogin = false});

  @override
  State<MasterWidget> createState() => _MasterWidgetState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _MasterWidgetState extends State<MasterWidget> {
  late VoidCallback globalNotifierListener;
  late NotificationProvider notificationProvider;

  Notifications notifications = Notifications(notifications: []);

  Color getColorBasedOnType(ToastType type) {
    switch (type) {
      case ToastType.Error:
        return const Color.fromARGB(255, 255, 74, 74);
      case ToastType.Success:
        return Colors.green;
      case ToastType.Warning:
        return Colors.orangeAccent;
      case ToastType.Info:
        return Colors.blue;
      default:
        return Colors.white;
    }
  }

  Icon getIconBasedOnToastType(ToastType type) {
    switch (type) {
      case ToastType.Error:
        return const Icon(
          Icons.error_outline,
          color: Colors.white,
        );
      case ToastType.Success:
        return const Icon(
          Icons.check_outlined,
          color: Colors.white,
        );
      case ToastType.Warning:
        return const Icon(
          Icons.warning_outlined,
          color: Colors.white,
        );
      case ToastType.Info:
        return const Icon(
          Icons.info_outline,
          color: Colors.white,
        );
      default:
        return const Icon(
          Icons.info_outline,
          color: Colors.white,
        );
    }
  }

  @override
  void initState() {
    super.initState();

    notificationProvider = context.read<NotificationProvider>();

    if (Globals.loggedUser != null) {
      runSignalR();

      loadNotifications();
    }

    globalNotifierListener = () {
      if (mounted) {
        setState(() {
          if (Globals.notifier.info.item1.isNotEmpty) {
            showToast(
                Globals.notifier.info.item1,
                getColorBasedOnType(Globals.notifier.info.item2),
                getIconBasedOnToastType(Globals.notifier.info.item2));
            Globals.notifier.setInfo("", ToastType.Unknown);
          }
          Globals.isAnyRequestActive = Globals.notifier.isAnyRequestActive;
          if (Globals.notifier.logoutUserImmediately) {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginScreen(),
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
                (Route<dynamic> route) => false);
            setState(() {
              Globals.notifier.logoutUserImmediately = false;
            });
          }
        });
      }
    };

    Globals.notifier.addListener(globalNotifierListener);
  }

  Future runSignalR() async {
    final connection = HubConnectionBuilder()
        .withUrl("${Globals.apiUrl}notification-hub",
            options: HttpConnectionOptions(
              accessTokenFactory: () async => Globals.loggedUser!.token,
            ))
        .build();

    await connection.start();

    if (Globals.loggedUser != null) {
      connection.on('${Topics.notification}#${Globals.loggedUser!.userId}',
          (arguments) {
        loadNotifications();
      });
    }
  }

  Future loadNotifications() async {
    var response = await notificationProvider.getAll();

    if (mounted) {
      setState(() {
        notifications = response;
      });
    }
  }

  void openSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SettingsDialog();
      },
    );
  }

  void showToast(String message, Color backgroundColor, Icon icon) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Toast(
        icon: icon,
        message: message,
        backgroundColor: backgroundColor,
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  void dispose() {
    Globals.notifier.removeListener(globalNotifierListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var unreadNotificationsCount = notifications.notifications
        .where((item) => item.status == NotificationStatus.Unread)
        .length;

    return widget.isLogin
        ? Scaffold(body: widget.child)
        : Stack(children: [
            Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey[900],
                elevation: 0,
                title: Row(
                  children: [
                    const Spacer(),
                    MenuAnchor(
                        builder: (BuildContext context,
                            MenuController controller, Widget? child) {
                          return Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                                icon: const Icon(Icons.notifications_outlined),
                              ),
                              if (unreadNotificationsCount > 0)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: Center(
                                      child: Text(
                                        unreadNotificationsCount > 9
                                            ? '9+'
                                            : '$unreadNotificationsCount',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        menuChildren: !notifications.notifications.any((item) =>
                                item.status == NotificationStatus.Unread)
                            ? [
                                const MenuItemButton(
                                    child: SizedBox(
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Nema novih obavijesti"),
                                        )))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigate.next(
                                            context,
                                            AppRoutes.notifications.routeName,
                                            const MyNotifications());
                                      },
                                      child: const Text("Pogledaj sve")),
                                )
                              ]
                            : [
                                ...notifications.notifications
                                    .where((item) =>
                                        item.status ==
                                        NotificationStatus.Unread)
                                    .take(3)
                                    .map((notification) => MenuItemButton(
                                          onPressed: () {},
                                          child: SizedBox(
                                            width: 450,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                title: Text(notification.title),
                                                subtitle: Text(
                                                    notification.description!),
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigate.next(
                                            context,
                                            AppRoutes.notifications.routeName,
                                            const MyNotifications());
                                      },
                                      child: const Text("Pogledaj sve")),
                                )
                              ]),
                    const SizedBox(width: 15),
                    IconButton(
                        onPressed: () {
                          openSettings();
                        },
                        icon: const Icon(Icons.settings_outlined)),
                    const SizedBox(width: 15),
                    IconButton(
                      icon: const Icon(Icons.logout_outlined),
                      onPressed: () {
                        Globals.notifier.logoutUser();
                      },
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              body: Row(
                children: [
                  Container(
                    width: 200,
                    color: Colors.grey[900],
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              children: [
                                Globals.image != null
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(Globals.image!.path)),
                                              fit: BoxFit.contain),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          Globals.loggedUser?.initials ?? "",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (Globals.loggedUser != null)
                                Text(
                                  '${Globals.loggedUser!.firstName} ${Globals.loggedUser!.lastName}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(context, AppRoutes.home.routeName,
                                  const Home(), true);
                            },
                            leading: const Icon(
                              Icons.home_outlined,
                              color: Colors.white,
                            ),
                            title: Text('Početna',
                                style: CustomTheme.menuItemTextStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(context, AppRoutes.home.routeName,
                                  const AccommodationUnits(), true);
                            },
                            leading: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            title: Text('Moji objekti',
                                style: CustomTheme.menuItemTextStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(
                                  context,
                                  AppRoutes.reviews.routeName,
                                  const Reviews(),
                                  true);
                            },
                            leading: const Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Recenzije',
                              style: CustomTheme.menuItemTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(
                                  context,
                                  AppRoutes.reservations.routeName,
                                  const Reservations(),
                                  true);
                            },
                            leading: const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Rezervacije',
                              style: CustomTheme.menuItemTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(context, AppRoutes.chat.routeName,
                                  const Guests(), true);
                            },
                            leading: const Icon(
                              Icons.people_outline_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Gosti',
                              style: CustomTheme.menuItemTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(
                                  context,
                                  AppRoutes.statistics.routeName,
                                  const Statistics(),
                                  true);
                            },
                            leading: const Icon(
                              Icons.bar_chart_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Statistika',
                              style: CustomTheme.menuItemTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(
                                  context,
                                  AppRoutes.maintenances.routeName,
                                  const Maintenances(),
                                  true);
                            },
                            leading: const Icon(
                              Icons.cleaning_services_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Održavanja',
                              style: CustomTheme.menuItemTextStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: ListTile(
                            onTap: () {
                              Navigate.next(context, AppRoutes.chat.routeName,
                                  const MyChat(), true);
                            },
                            leading: const Icon(
                              Icons.chat_bubble_outline_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Chat',
                              style: CustomTheme.menuItemTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(child: widget.child),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: Globals.isAnyRequestActive,
              child: Positioned.fill(
                child: Center(
                  child: Dialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 100,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoaderIndicator(tickCount: 8, radius: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]);
  }
}
