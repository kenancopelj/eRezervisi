import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/main.dart';
import 'package:erezervisi_mobile/models/requests/user/user_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/shared/components/form/button.dart';
import 'package:erezervisi_mobile/shared/components/form/input.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/validators/auth/register.dart';
import 'package:flutter/material.dart';
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

  late UserProvider userProvider;

  var validator = RegisterValidator();

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

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
                  validator: validator.required,
                  label: "Broj telefona",
                  hintText: "e.g. +387616161",
                ),
                Input(
                  controller: addressController,
                  validator: validator.required,
                  label: "Adresa",
                  hintText: "e.g. Ulica 13, Mostar",
                ),
                Input(
                  controller: emailController,
                  validator: validator.required,
                  label: "Email",
                  hintText: "e.g. name@example.com",
                ),
                Input(
                  controller: usernameController,
                  validator: validator.required,
                  label: "Korisničko ime",
                  hintText: "Unesite Vaše korisničko ime",
                ),
                Input(
                  controller: passwordController,
                  validator: validator.required,
                  label: "Lozinka",
                  hintText: "Unesite Vašu lozinku",
                ),
                Input(
                  controller: passwordController,
                  validator: validator.required,
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
        email: addressController.text,
        username: usernameController.text,
        password: passwordController.text);

    UserGetDto? response;

    try {
      response = await userProvider.create(payload);
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }

    if (response != null && mounted) {
      Navigate.next(context, AppRoutes.login.routeName, const LoginScreen(), true);
    }
  }
}
