// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/helpers/file_helper.dart';
import 'package:erezervisi_mobile/main.dart';
import 'package:erezervisi_mobile/models/requests/image/image_create_dto.dart';
import 'package:erezervisi_mobile/providers/file_provider.dart';
import 'package:erezervisi_mobile/screens/favorites.dart';
import 'package:erezervisi_mobile/screens/home.dart';
import 'package:erezervisi_mobile/screens/notifications.dart';
import 'package:erezervisi_mobile/screens/profile.dart';
import 'package:erezervisi_mobile/screens/search.dart';
import 'package:erezervisi_mobile/shared/components/loader.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/navigator/routes.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Color resultColor;

    if (type == ToastType.Error) {
      resultColor = const Color.fromARGB(255, 255, 74, 74);
    } else if (type == ToastType.Success) {
      resultColor = Colors.green;
    } else if (type == ToastType.Warning) {
      resultColor = Colors.orangeAccent;
    } else if (type == ToastType.Info) {
      resultColor = Colors.blue;
    } else {
      resultColor = Colors.white;
    }

    return resultColor;
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
                      const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
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
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
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

  List<BottomNavigationRoute> routes = [
    BottomNavigationRoute(
        icon: const Icon(
          Icons.home,
        ),
        route: BarRoute.Home,
        name: AppRoutes.home.routeName),
    BottomNavigationRoute(
        icon: const Icon(Icons.favorite),
        route: BarRoute.Favorites,
        name: AppRoutes.favorites.routeName),
    BottomNavigationRoute(
        icon: const Icon(Icons.search),
        route: BarRoute.Search,
        name: AppRoutes.search.routeName),
    BottomNavigationRoute(
        icon: const Icon(Icons.notifications),
        route: BarRoute.Notifications,
        name: AppRoutes.notifications.routeName),
    BottomNavigationRoute(
        icon: const Icon(Icons.person),
        route: BarRoute.Profile,
        name: AppRoutes.profile.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return widget.isLogin
        ? Scaffold(
            body: widget.child,
          )
        : Stack(children: [
            Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                leading: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: IconButton(
                      splashRadius: 1,
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ),
                title: const Text("eRezervisi"),
              ),
              drawer: const eRezervisiDrawer(),
              body: widget.child,
              bottomNavigationBar: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: routes
                      .map(
                        (x) => IconButton(
                          color: selectionColor(x.route),
                          icon: x.route == BarRoute.Profile
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                          image: Globals.image != null
                                              ? FileImage(File(
                                                  Globals.image!.path))
                                              : const AssetImage(
                                                  "assets/images/user.png"))),
                                )
                              : x.icon,
                          onPressed: () => navigate(x),
                        ),
                      )
                      .toList() as List<Widget>,
                ),
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
                          LoaderIndicator(
                            tickCount: 8,
                            radius: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ]);
  }
}
