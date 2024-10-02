import 'dart:io';
import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/helpers/file_helper.dart';
import 'package:erezervisi_desktop/main.dart';
import 'package:erezervisi_desktop/models/requests/image/image_create_dto.dart';
import 'package:erezervisi_desktop/providers/file_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units.dart';
import 'package:erezervisi_desktop/screens/chat.dart';
import 'package:erezervisi_desktop/screens/favorites.dart';
import 'package:erezervisi_desktop/screens/home.dart';
import 'package:erezervisi_desktop/screens/my_reviews.dart';
import 'package:erezervisi_desktop/screens/notifications.dart';
import 'package:erezervisi_desktop/screens/profile.dart';
import 'package:erezervisi_desktop/screens/reservations.dart';
import 'package:erezervisi_desktop/screens/reviews.dart';
import 'package:erezervisi_desktop/screens/search.dart';
import 'package:erezervisi_desktop/screens/settings.dart';
import 'package:erezervisi_desktop/shared/components/loader.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/custom_page_route.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/shared/navigator/routes.dart';
import 'package:erezervisi_desktop/shared/style.dart';
import 'package:flutter/material.dart';

class MasterWidget extends StatefulWidget {
  final Widget child;
  bool isLogin;
  MasterWidget({super.key, required this.child, this.isLogin = false});

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

  @override
  void initState() {
    super.initState();

    globalNotifierListener = () {
      if (mounted) {
        setState(() {
          if (Globals.notifier.info.item1.isNotEmpty) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                  constraints: const BoxConstraints(maxHeight: 130),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.info, color: Colors.white),
                      const SizedBox(width: 12.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          Globals.notifier.info.item1,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(20),
                shape: const StadiumBorder(),
                backgroundColor:
                    getColorBasedOnType(Globals.notifier.info.item2),
                duration: const Duration(milliseconds: 1500),
              ),
            );
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

  @override
  void dispose() {
    Globals.notifier.removeListener(globalNotifierListener);
    super.dispose();
  }

  BarRoute selectedRoute = BarRoute.Home;

  void navigate(BottomNavigationRoute route) {
    setState(() {
      selectedRoute = route.route;
    });

    mapRoute(selectedRoute);
  }

  mapRoute(selectedRoute) {
    switch (selectedRoute) {
      case BarRoute.Home:
        Navigate.next(context, AppRoutes.home.routeName, const Home(), true);
        break;
      case BarRoute.Favorites:
        Navigate.next(
            context, AppRoutes.favorites.routeName, const MyFavourites(), true);
        break;
      case BarRoute.Search:
        Navigate.next(
            context, AppRoutes.search.routeName, const Search(), true);
        break;
      case BarRoute.Notifications:
        Navigate.next(context, AppRoutes.notifications.routeName,
            const MyNotifications(), true);
        break;
      case BarRoute.Profile:
        Navigate.next(
            context, AppRoutes.profile.routeName, const MyProfile(), true);
        break;
      default:
        break;
    }
  }

  Color selectionColor(BarRoute route) {
    if (route == selectedRoute) return Style.secondaryColor;
    return Style.primaryColor100;
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
                              Navigate.next(context, AppRoutes.chat.routeName,
                                  const MyChat(), true);
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyReviews()));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyReviews()));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyReviews()));
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
