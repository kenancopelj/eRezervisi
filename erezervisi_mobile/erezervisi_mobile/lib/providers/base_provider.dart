import 'dart:convert';

import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BaseProvider with ChangeNotifier {
  Dio dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20)));

  BaseProvider() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      bool skipDefaultLoader = options.extra['skipDefaultLoader'] ?? false;
      if (skipDefaultLoader == false) {
        Globals.notifier.setRequestActive();
      }
      if (Globals.loggedUser != null) {
        options.headers['Authorization'] =
            'bearer ${Globals.loggedUser!.token}';
      }
      options.headers['User-Agent'] = 'mobile-android.erezervisii';
      return handler.next(options);
    }, onResponse: (response, handler) {
      bool skipDefaultLoader =
          response.requestOptions.extra['skipDefaultLoader'] ?? false;
      if (skipDefaultLoader == false) {
        Globals.notifier.setRequestInactive();
      }
      return handler.next(response);
    }, onError: (DioException e, handler) {
      print(e.message);
      Globals.notifier.setRequestInactive();
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          {
            Globals.notifier.setInfo(
                "Konekcija nije stabilna. Molimo osigurajte stabilnu internet konekciju i pokušajte ponovo.",
                ToastType.Warning);
          }
        case DioExceptionType.receiveTimeout:
          {
            Globals.notifier.setInfo(
                "Konekcija nije stabilna. Molimo osigurajte stabilnu internet konekciju i pokušajte ponovo.",
                ToastType.Warning);
          }
        default:
          break;
      }
      var info = e.response?.data["Error"];
      Globals.notifier.setInfo(info, ToastType.Error);
      try {
        if (e.response?.statusCode == 401 || e.response?.data.status == 401) {
          if (Globals.loggedUser != null &&
              Globals.loggedUser!.token.isNotEmpty) {
            Globals.notifier.logoutUser();
          }
        }
      } catch (_) {}

      return handler.next(e);
    }));
  }

  Future<void> checkConnectivity() async {
    try {
      final response = await dio.get('https://www.google.com');
      if (response.statusCode != 200) {
        Globals.notifier.setInfo(
            "Nije moguće uspostaviti vezu. Molimo provjerite vašu internet konekciju i pokušajte ponovo.",
            ToastType.Warning);
      }
    } catch (e) {
      Globals.notifier.setInfo(
          "Izgleda da ste van mreže. Molimo provjerite vašu internet konekciju i pokušajte ponovo.",
          ToastType.Warning);
    }
  }
}
