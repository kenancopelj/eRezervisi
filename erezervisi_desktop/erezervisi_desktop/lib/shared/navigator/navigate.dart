import 'package:erezervisi_desktop/shared/navigator/custom_page_route.dart';
import 'package:flutter/material.dart';

class Navigate {
  Navigate._();

  static next(BuildContext context, String routeName, Widget next,
      [bool followRoute = false]) {
    if (!followRoute) {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => next),
          (Route<dynamic> route) => false);
    } else {
      Navigator.push(
          context,
          CustomPageRoute(
              builder: (_) => next, settings: RouteSettings(name: routeName)));
    }
  }
}
