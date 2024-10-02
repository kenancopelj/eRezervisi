import 'package:erezervisi_desktop/enums/reservation_status.dart';
import 'package:flutter/material.dart';

class Style {
  static Color primaryColor100 = const Color.fromARGB(255, 35, 31, 32);
  static Color primaryColor70 = const Color.fromARGB(178, 35, 31, 32);
  static Color primaryColor50 = const Color.fromARGB(127, 35, 31, 32);
  static Color secondaryColor = Color.fromARGB(255, 12, 84, 166);
  static Color warningColor = const Color.fromARGB(255, 253, 197, 0);
  static Color infoColor = const Color.fromARGB(255, 21, 133, 181);
  static Color errorColor = const Color.fromARGB(255, 216, 2, 17);
  static Color borderColor = const Color.fromARGB(255, 218, 217, 217);
  static Color linkColor = Colors.transparent;

  static Color statusOpened = const Color.fromARGB(255, 1, 101, 213);
  static Color statusSolved = const Color.fromARGB(255, 0, 120, 102);
  static Color statusClosed = const Color.fromARGB(255, 92, 109, 115);

  static Color priorityLow = const Color.fromARGB(255, 0, 120, 102);
  static Color priorityMedium = const Color.fromARGB(255, 253, 197, 0);
  static Color priorityHigh = const Color.fromARGB(255, 216, 2, 17);

  static Color textRegularBlack = const Color.fromARGB(255, 73, 72, 72);

  static Color inputBackgroundColor = const Color.fromARGB(255, 249, 249, 249);

  static Color loaderColor = const Color.fromARGB(255, 255, 255, 255);

  static Color observationBackground70 =
      const Color.fromARGB(178, 246, 246, 246);
  static Color observationBackground100 =
      const Color.fromARGB(178, 246, 246, 246);

  static Color dropdownSufixColor = const Color.fromARGB(176, 140, 140, 140);
  static Color dropdownCancelSufixColor =
      const Color.fromARGB(175, 189, 189, 189);

  static double labelFontSize = 12;
  static double fieldFontSize = 12;
  static double errorFontSize = 12;
  static double borderSize = 0.5;
  static double textObservationFontSize = 11;

  static Color getColorByStatus(ReservationStatus status) {
    if (status == ReservationStatus.Draft) {
      return statusOpened;
    } else if (status == ReservationStatus.Confirmed) {
      return statusSolved;
    } else if (status == ReservationStatus.InProgress) {
      return statusClosed;
    }
    return const Color.fromARGB(255, 253, 153, 52);
  }
}
