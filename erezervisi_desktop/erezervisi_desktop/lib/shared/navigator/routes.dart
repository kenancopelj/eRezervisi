// ignore_for_file: constant_identifier_names

// Navigation bar routes
import 'package:flutter/material.dart';

enum BarRoute { Unknown, Home, Favorites, Search, Notifications, Profile }

class BottomNavigationRoute {
  late Icon icon;
  late BarRoute route;
  late String name;

  BottomNavigationRoute(
      {required this.icon, required this.route, required this.name});
}
