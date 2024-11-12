import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/main.dart';
import 'package:erezervisi_desktop/models/responses/user/reset_password_dto.dart';
import 'package:erezervisi_desktop/providers/user_provider.dart';
import 'package:erezervisi_desktop/shared/components/form/button.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/shared/validators/forgotten-password/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({required this.email, super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();

  var validator = ForgottenPasswordValidator();

  final formKey = GlobalKey<FormState>();

  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();
  }

  Future handleSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var response = await userProvider.resetPassword(ResetPasswordDto(
        email: widget.email, newPassword: newPasswordController.text));

    if (response && mounted) {
      Navigate.next(context, AppRoutes.login.routeName, const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    RegExp numberRegex = RegExp(r'[0-9]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 750, vertical: 250),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Reset lozinke",
                    style: CustomTheme.mediumTextStyle,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    decoration: const InputDecoration(
                        label: Text("Lozinka"),
                        border: OutlineInputBorder(),
                        hintText: "Unesite Vašu novu lozinku"),
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Obavezno polje\n';
                      } else if (value != passwordController.text) {
                        return 'Lozinke se ne poklapaju\n';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    decoration: const InputDecoration(
                        label: Text("Ponovljena lozinka"),
                        border: OutlineInputBorder(),
                        hintText: "Unesite Vašu ponovljenu lozinku"),
                    controller: newPasswordController,
                  ),
                  Button(
                    label: "SPREMI",
                    onClick: handleSubmit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
