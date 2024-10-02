import 'package:dio/dio.dart';
import 'package:erezervisi_desktop/models/requests/base/base_get_all_request.dart';
import 'package:erezervisi_desktop/models/requests/base/base_paged_request.dart';
import 'package:erezervisi_desktop/models/responses/auth/jwt_token_response.dart';
import 'package:erezervisi_desktop/models/responses/notification/notifications.dart';
import 'package:erezervisi_desktop/notifiers/global_notifier.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Globals {
  Globals._();
  // static String apiUrl = "http://localhost:5269/"; -- Docker
  static String apiUrl = "https://localhost:7158/";

  static Notifications notifications = Notifications(notifications: []);

  static JwtTokenResponse? loggedUser;

  static bool enableNotifications = true;

  static XFile? image;

  static GlobalNotifier notifier = GlobalNotifier();

  static String erezervisiKeyUsername = "erezervisi_username";
  static String erezervisiKeyPassword = "erezervisi_password";
  static String erezervisiKeyRememberMe = "erezervisi_remember_me";
  static String erezervisiKeyUser = "erezervisi_user";
  static String erezervisiKeyKeyboardHeight = "erezervisi_keyboard_height";
  static String erezervisiKeyGetNotifications = "erezervisi_get_notifications";

  static int pageSize = 10;

  static double keyboardHeight = 0;

  static bool isAnyRequestActive = false;

  static Options skipDefaultLoader =
      Options().copyWith(extra: <String, bool>{'skipDefaultLoader': true});

  static String dateFormat = "dd.MM.yyyy";
  static String timeFormat = "HH:mm";

  static int? imageQuality = 85;
  static double? imageMaxHeight = 1000;
  static double? imageMaxWidth = 1000;

  static BaseGetAllRequest baseGetAllRequest =
      BaseGetAllRequest(searchTerm: '');

  static BasePagedRequest basePagedRequest = BasePagedRequest(
      page: 1,
      pageSize: pageSize,
      searchTerm: "",
      orderByColumn: "",
      orderBy: "");
}
