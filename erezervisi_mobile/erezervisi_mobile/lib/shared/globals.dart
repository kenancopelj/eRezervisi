import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/models/requests/base/base_get_all_request.dart';
import 'package:erezervisi_mobile/models/requests/base/base_paged_request.dart';
import 'package:erezervisi_mobile/models/responses/auth/jwt_token_response.dart';
import 'package:erezervisi_mobile/notifiers/global_notifier.dart';
import 'package:flutter/material.dart';

class Globals {
  Globals._();
  static String apiUrl = "https://localhost:7158/";

  static JwtTokenResponse? loggedUser;

  static GlobalNotifier notifier = GlobalNotifier();

  static String erezerivisKeyUsername = "erezervisi_username";
  static String erezerivisKeyPassword = "erezervisi_password";
  static String erezerivisKeyRememberMe = "erezervisi_remember_me";
  static String erezerivisKeyUser = "erezervisi_user";
  static String erezerivisKeyKeyboardHeight = "erezervisi_keyboard_height";

  static int pageSize = 20;

  static double keyboardHeight = 0;

  static bool isAnyRequestActive = false;

  static Options skipDefaultLoader =
      Options().copyWith(extra: <String, bool>{'skipDefaultLoader': true});

  static String dateFormat = "dd.MM.yyyy";
  static String timeFormat = "HH:mm";

  static int? imageQuality = 85;
  static double? imageMaxHeight = 1000;
  static double? imageMaxWidth = 1000;

  static navigate(BuildContext context, Widget next,
      [bool followRoute = false]) {
    if (followRoute) {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => next),
          (Route<dynamic> route) => false);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => next));
    }
  }

  static BaseGetAllRequest baseGetAllRequest =
      BaseGetAllRequest(searchTerm: '');

  static BasePagedRequest basePagedRequest = BasePagedRequest(
      page: 1,
      pageSize: pageSize,
      searchTerm: "",
      orderByColumn: "",
      orderBy: "");
}
