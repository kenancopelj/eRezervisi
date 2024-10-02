import 'package:erezervisi_desktop/shared/style.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static Color lightPrimaryColor = const Color.fromARGB(255, 245, 245, 252);
  static Color bluePrimaryColor = const Color.fromARGB(255, 38, 76, 134);
  static Color secondaryBlackColor = Colors.black;
  static TextStyle smallTextStyle =
      const TextStyle(color: Colors.black, fontSize: 12);
  static TextStyle menuItemTextStyle =
      const TextStyle(color: Colors.white, fontSize: 12);
  static TextStyle mediumTextStyle =
      const TextStyle(color: Colors.black, fontSize: 20);
  static TextStyle largeTextStyle = const TextStyle(
      color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);
  static Color sortByColor = const Color.fromARGB(255, 158, 158, 158);
  static TextStyle sortByTextStyle =
      const TextStyle(color: Color.fromARGB(255, 158, 158, 158));
  static TextStyle homeCardTitleTextStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18);
  static TextStyle homeCardSubTitleTextStyle = const TextStyle(
      color: Color.fromARGB(255, 158, 158, 158),
      fontWeight: FontWeight.w400,
      fontSize: 12);
  static TextStyle homeCardValueTextStyle = TextStyle(
      color: Colors.blue[700], fontWeight: FontWeight.w400, fontSize: 20);

  MaterialColor myColor = const MaterialColor(0xFF231F20, {
    50: Color(0xFF231F20),
    100: Color(0xFF231F20),
    200: Color(0xFF231F20),
    300: Color(0xFF231F20),
    400: Color(0xFF231F20),
    500: Color(0xFF231F20),
    600: Color(0xFF231F20),
    700: Color(0xFF231F20),
    800: Color(0xFF231F20),
    900: Color(0xFF231F20)
  });

  static ThemeData themeData = ThemeData(
      fontFamily: 'MonaSans',
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: Style.primaryColor100,
          selectionColor: const Color.fromARGB(255, 157, 157, 157),
          selectionHandleColor: Colors.black),
      primarySwatch: const MaterialColor(0xFF231F20, {
        50: Color(0xFF231F20),
        100: Color(0xFF231F20),
        200: Color(0xFF231F20),
        300: Color(0xFF231F20),
        400: Color(0xFF231F20),
        500: Color(0xFF231F20),
        600: Color(0xFF231F20),
        700: Color(0xFF231F20),
        800: Color(0xFF231F20),
        900: Color(0xFF231F20)
      }),
      useMaterial3: false);
}
