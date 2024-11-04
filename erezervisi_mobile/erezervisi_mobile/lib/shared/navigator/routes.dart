// ignore_for_file: constant_identifier_names

// Navigation bar routes
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';

enum BarRoute { Unknown, Home, Favorites, Search, Notifications, Profile }

class BottomNavigationRoute {
  late Icon icon;
  late AppRoutes route;
  late String name;

  BottomNavigationRoute(
      {required this.icon, required this.route, required this.name});
}
