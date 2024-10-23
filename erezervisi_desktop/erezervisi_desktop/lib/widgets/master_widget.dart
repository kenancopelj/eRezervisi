import 'dart:io';
import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/main.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/accommodation_units.dart';
import 'package:erezervisi_desktop/screens/guests/guests.dart';
import 'package:erezervisi_desktop/screens/home.dart';
import 'package:erezervisi_desktop/screens/reservations/reservations.dart';
import 'package:erezervisi_desktop/screens/reviews/reviews.dart';
import 'package:erezervisi_desktop/screens/statistics/statistics.dart';
import 'package:erezervisi_desktop/shared/components/loader.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/widgets/maintenances/maintenances.dart';
import 'package:erezervisi_desktop/widgets/toast.dart';
import 'package:flutter/material.dart';

class MasterWidget extends StatefulWidget {
  final Widget child;
  final bool isLogin;
  const MasterWidget({super.key, required this.child, this.isLogin = false});

  @override
  State<MasterWidget> createState() => _MasterWidgetState();
}

class _MasterWidgetState extends State<MasterWidget> {
  late VoidCallback globalNotifierListener;

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
                    const Icon(Icons.notifications_outlined),
                    const SizedBox(width: 15),
                    const Icon(Icons.settings_outlined),
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
                                          Globals.loggedUser!.initials,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
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
                              Icons.request_page_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Održavanja',
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
