import 'package:flutter/material.dart';

class Navigate {
  Navigate._();

  static next(BuildContext context, Widget next, [bool followRoute = false]) {
    if (!followRoute) {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => next),
          (Route<dynamic> route) => false);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => next));
    }
  }
}
