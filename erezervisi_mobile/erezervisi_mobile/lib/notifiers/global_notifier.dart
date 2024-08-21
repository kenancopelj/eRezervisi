import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalNotifier extends ChangeNotifier {
  bool _isAnyRequestActive = false;
  int _numberOfRequests = 0;
  bool get isAnyRequestActive => _isAnyRequestActive;
  bool logoutUserImmediately = false;

  Tuple2<String, ToastType> info = const Tuple2('', ToastType.Unknown);

  setInfo(String info, ToastType type) {
    this.info = Tuple2(info, type);
    if (info.isNotEmpty) {
      notifyListeners();
    }
  }

  setRequestActive() {
    _isAnyRequestActive = true;
    _numberOfRequests++;
    notifyListeners();
  }

  setRequestInactive() {
    _numberOfRequests--;
    if (_numberOfRequests == 0) _isAnyRequestActive = false;
    notifyListeners();
  }

  logoutUser() async {
    logoutUserImmediately = true;
    Globals.loggedUser = null;

    final prefs = await SharedPreferences.getInstance();

    try {
      var erezervisiKeyUser = prefs.getString("erezervisi_user");
      if (erezervisiKeyUser != null && erezervisiKeyUser.isNotEmpty) {
        prefs.setString("erezervisi_user", "");
      }
    } catch (_) {}
    notifyListeners();
  }
}
