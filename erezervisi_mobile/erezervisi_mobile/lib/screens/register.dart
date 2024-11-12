import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/main.dart';
import 'package:erezervisi_mobile/models/requests/user/user_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_email_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_phone_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/check_username_dto.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/shared/components/form/button.dart';
import 'package:erezervisi_mobile/shared/components/form/input.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/validators/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final registerKey = GlobalKey<FormState>();

  final Debouncer debouncer = Debouncer();

  late UserProvider userProvider;

  var validator = RegisterValidator();

  bool duplicateUsername = false;
  bool duplicateEmail = false;
  bool duplicatePhoneNumber = false;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();
  }

  Future checkUsername(username) async {
    var response =
        await userProvider.checkUsername(CheckUsernameDto(username: username));

    setState(() {
      duplicateUsername = response;
    });
  }

  Future checkPhoneNumber(phoneNumber) async {
    var response = await userProvider
        .checkPhoneNumber(CheckPhoneDto(phoneNumber: phoneNumber));

    setState(() {
      duplicatePhoneNumber = response;
    });
  }

  Future checkEmail(email) async {
    var response = await userProvider.checkEmail(CheckEmailDto(email: email));

    setState(() {
      duplicateEmail = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    RegExp numberRegex = RegExp(r'[0-9]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');

    return Scaffold(
        body: Form(
      key: registerKey,
      child: SizedBox(
        width: w,
        height: h,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kreirajte novi nalog",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Input(
                  controller: firstNameController,
                  validator: validator.required,
                  label: "Ime",
                  hintText: "Unesite Vaše ime",
                ),
                Input(
                  controller: lastNameController,
                  validator: validator.required,
                  label: "Prezime",
                  hintText: "Unesite Vaše prezime",
                ),
                Input(
                  controller: phoneController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obavezno polje';
                    }
                    if (duplicatePhoneNumber) {
                      return 'Broj telefona je već u upotrebi';
                    }
                    return null;
                  },
                  label: "Broj telefona",
                  hintText: "e.g. +387616161",
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      debouncer.debounce(
                          duration: Globals.debounceTimeout,
                          onDebounce: () {
                            checkPhoneNumber(value);
                          });
                    }
                  },
                ),
                Input(
                  controller: addressController,
                  validator: validator.required,
                  label: "Adresa",
                  hintText: "e.g. Ulica 13, Mostar",
                ),
                Input(
                  controller: emailController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obavezno polje';
                    }
                    if (duplicateEmail) {
                      return 'Email je već u upotrebi';
                    }
                    return null;
                  },
                  label: "Email",
                  hintText: "e.g. name@example.com",
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      debouncer.debounce(
                          duration: Globals.debounceTimeout,
                          onDebounce: () {
                            checkEmail(value);
                          });
                    }
                  },
                ),
                Input(
                  controller: usernameController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obavezno polje';
                    }
                    if (duplicateUsername) {
                      return 'Korisničko ime je već u upotrebi';
                    }
                    return null;
                  },
                  label: "Korisničko ime",
                  hintText: "Unesite Vaše korisničko ime",
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      debouncer.debounce(
                          duration: Globals.debounceTimeout,
                          onDebounce: () {
                            checkUsername(value);
                          });
                    }
                  },
                ),
                Input(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obavezno polje\n';
                    } else if (!numberRegex.hasMatch(value) ||
                        !uppercaseRegex.hasMatch(value)) {
                      return 'Lozinka mora sadržavati:\n- Minimalno jedan broj\n- Minimalno jedno veliko slovo\n';
                    } else if (!uppercaseRegex.hasMatch(value)) {
                      return 'Lozinka mora sadržavati barem jedno veliko slovo\n';
                    } else if (value.length < 6) {
                      return 'Lozinka mora sadržavati barem 6 karaktera\n';
                    }
                    return null;
                  },
                  label: "Lozinka",
                  obscureText: true,
                  hintText: "Unesite Vašu lozinku",
                ),
                Input(
                  controller: confirmPasswordController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Obavezno polje';
                    }
                    if (value != passwordController.text) {
                      return 'Lozinke se ne poklapaju';
                    }
                    return null;
                  },
                  obscureText: true,
                  label: "Ponovljena lozinka",
                  hintText: "Potvrdite Vašu lozinku",
                ),
                const SizedBox(
                  height: 10,
                ),
                Button(
                  onClick: handleSubmit,
                  label: "REGISTRUJ SE",
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future handleSubmit() async {
    if (!registerKey.currentState!.validate()) {
      return;
    }

    var payload = UserCreateDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        address: addressController.text,
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text);

    try {
      await userProvider.create(payload);
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
      return;
    }

    if (mounted) {
      Navigate.next(
          context, AppRoutes.login.routeName, const LoginScreen(), true);
    }
  }
}
