// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/button_type.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/helpers/file_helper.dart';
import 'package:erezervisi_mobile/models/requests/auth/auth_dto.dart';
import 'package:erezervisi_mobile/models/responses/auth/jwt_token_response.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/auth_provider.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/providers/category_provider.dart';
import 'package:erezervisi_mobile/providers/favorites_provider.dart';
import 'package:erezervisi_mobile/providers/message_provider.dart';
import 'package:erezervisi_mobile/providers/notification_provider.dart';
import 'package:erezervisi_mobile/providers/payment_provider.dart';
import 'package:erezervisi_mobile/providers/reservation_provider.dart';
import 'package:erezervisi_mobile/providers/township_provider.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/screens/home.dart';
import 'package:erezervisi_mobile/screens/register.dart';
import 'package:erezervisi_mobile/shared/components/form/button.dart';
import 'package:erezervisi_mobile/shared/components/form/checkbox.dart';
import 'package:erezervisi_mobile/shared/components/form/input.dart';
import 'package:erezervisi_mobile/shared/components/loader.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/shared/validators/auth/login.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 HttpOverrides.global = MyHttpOverrides();

  Stripe.publishableKey =
      const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY', defaultValue: "");

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final prefs = await SharedPreferences.getInstance();

  try {
    var erezervisiKeyUser = prefs.getString(Globals.erezervisiKeyUser);

    Globals.keyboardHeight =
        prefs.getDouble(Globals.erezervisiKeyKeyboardHeight) ?? 0;

    if (erezervisiKeyUser != null && erezervisiKeyUser.isNotEmpty) {
      Globals.loggedUser =
          JwtTokenResponse.fromJson(jsonDecode(erezervisiKeyUser));

      if (!Globals.loggedUser!.expiresAtUtc.isAfter(DateTime.now().toUtc())) {
        Globals.loggedUser = null;

        prefs.setString(Globals.erezervisiKeyUser, "");
      }
    }
  } catch (_) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BaseProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => AccommodationUnitProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(
            create: (_) => FavoritesProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ReservationProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => NotificationProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MessageProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => TownshipProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PaymentProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'eRezervisi',
          builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? const Text("")),
          theme: CustomTheme.themeData,
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            curve: Curves.linear,
            duration: 300,
            splashIconSize: MediaQuery.of(context).size.height,
            splash: Column(
              children: [
                Expanded(child: Container()),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'eRezervisi',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.normal,
                              color: Style.primaryColor100),
                        ),
                        const Spacer(),
                        const Center(
                          child: LoaderIndicator(
                            tickCount: 8,
                            radius: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(110, 0, 110, 40),
                      child: Container(
                        constraints:
                            const BoxConstraints(maxHeight: 200, maxWidth: 450),
                        child: const Text("eRezervisi"),
                      ),
                    ),
                  ),
                ))
              ],
            ),
            nextScreen:
                Globals.loggedUser != null ? const Home() : const LoginScreen(),
            backgroundColor: Colors.white,
          ),
        ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = encrypt.Key.fromUtf8("AbCdEfGhIjKLMnOpQrStUvWxYz123456");
  final iv = encrypt.IV.fromBase64("oBuosxPBBuOTYW76");

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool rememberMe = false;
  bool hidePassword = true;

  late AuthProvider authProvider;

  var validator = AuthValidator();

  final _loginKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    getRememberMe();

    authProvider = context.read<AuthProvider>();
  }

  Future<void> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt("------", iv: iv).base64;

    var savedUsername = prefs.getString(Globals.erezervisiKeyUsername) ?? '';
    var savePassword = prefs.getString(Globals.erezervisiKeyPassword) ?? '';

    if (savedUsername == '') {
      prefs.setString(Globals.erezervisiKeyUsername, encrypted);
    }
    if (savePassword == '') {
      prefs.setString(Globals.erezervisiKeyPassword, encrypted);
    }

    if ((prefs.getBool(Globals.erezervisiKeyRememberMe) ?? false) == false) {
      prefs.setBool(Globals.erezervisiKeyRememberMe, false);
    } else {
      setState(() {
        rememberMe = true;
      });

      var u1 = prefs.getString(Globals.erezervisiKeyUsername);
      var p1 = prefs.getString(Globals.erezervisiKeyPassword);

      final u1EncryptedAlready = encrypt.Key.fromBase64(u1!);
      final u1Decrypted = encrypter.decrypt(u1EncryptedAlready, iv: iv);
      _usernameController.text = u1Decrypted == "------" ? "" : u1Decrypted;

      final p1EncryptedAlready = encrypt.Key.fromBase64(p1!);
      final p1Decrypted = encrypter.decrypt(p1EncryptedAlready, iv: iv);
      _passwordController.text = p1Decrypted == "------" ? "" : p1Decrypted;
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return MasterWidget(
      isLogin: true,
      child: Scaffold(
          body: Form(
        key: _loginKey,
        child: SizedBox(
          width: w,
          height: h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  "Dobro došli!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    Input(
                      controller: _usernameController,
                      validator: validator.required,
                      label: 'Korisničko ime',
                      hintText: "korisnik@example.com",
                    ),
                    Input(
                      controller: _passwordController,
                      validator: validator.required,
                      obscureText: true,
                      label: 'Lozinka',
                      hintText: "Unesite Vašu lozinku",
                    ),
                    FormSwitch(
                        label: 'Zapamti me',
                        value: rememberMe,
                        onChange: handleRememberMeChange),
                    Button(
                      label: "PRIJAVI SE",
                      onClick: handleSubmit,
                    ),
                    Button(
                      label: "Nemate nalog? Registrujte se",
                      type: ButtonType.Link,
                      onClick: navigateToRegisterScreen,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  handleRememberMeChange(newValue) {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  Color switchColor() {
    if (rememberMe) {
      return Style.primaryColor100;
    }
    return Colors.white;
  }

  navigateToRegisterScreen() {
    Navigate.next(
        context, AppRoutes.register.routeName, const RegisterScreen(), true);
  }

  Future handleSubmit() async {
    if (!_loginKey.currentState!.validate()) {
      return;
    }

    var payload = AuthDto(
        username: _usernameController.text, password: _passwordController.text);

    JwtTokenResponse? response;

    try {
      response = await authProvider.login(payload);
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }

    if (response != null) {
      Globals.loggedUser = response;

      var prefs = await SharedPreferences.getInstance();
      var encrypter = encrypt.Encrypter(encrypt.AES(key));

      var encryptedUsername = "";
      var encryptedPassword = "";

      if (rememberMe) {
        encryptedUsername =
            encrypter.encrypt(_usernameController.text, iv: iv).base64;
        encryptedPassword =
            encrypter.encrypt(_passwordController.text, iv: iv).base64;
      } else {
        encryptedUsername = encrypter.encrypt("------", iv: iv).base64;
        encryptedPassword = encrypter.encrypt("------", iv: iv).base64;
      }

      prefs.setString(Globals.erezervisiKeyUsername, encryptedUsername);
      prefs.setString(Globals.erezervisiKeyPassword, encryptedPassword);
      prefs.setBool(Globals.erezervisiKeyRememberMe, rememberMe);
      prefs.setBool(Globals.erezervisiKeyGetNotifications,
          Globals.loggedUser!.receiveNotifications);

      var responseString = jsonEncode(response.toJson());
      prefs.setString(Globals.erezervisiKeyUser, responseString);

      Navigate.next(context, AppRoutes.home.routeName, const Home(), true);
    }
  }
}
