import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/user/request_code_dto.dart';
import 'package:erezervisi_desktop/providers/user_provider.dart';
import 'package:erezervisi_desktop/screens/forgotten-password/check-code.dart';
import 'package:erezervisi_desktop/shared/components/form/button.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/shared/validators/base_validator.dart';
import 'package:erezervisi_desktop/shared/validators/forgotten-password/request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestCodeScreen extends StatefulWidget {
  const RequestCodeScreen({super.key});

  @override
  State<RequestCodeScreen> createState() => _RequestCodeScreenState();
}

class _RequestCodeScreenState extends State<RequestCodeScreen> {
  var emailController = TextEditingController();

  var validator = ForgottenPasswordValidator();

  final formKey = GlobalKey<FormState>();

  late UserProvider userProvider;

  RegExp get _emailRegex => RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+(?:\.[a-zA-Z]{2,}){1,2}$");

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();
  }

  Future handleSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var response = await userProvider.requestForgottenPasswordCode(
        RequestCodeDto(email: emailController.text));

    if (response && mounted) {
      Navigate.next(context, AppRoutes.checkCode.routeName,
          CheckCodeScreen(email: emailController.text), true);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Obavezno polje\n';
                      } else if (!_emailRegex.hasMatch(value)) {
                        return 'Email adresa nije u ispravnom formatu\n';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("E-mail"),
                        border: OutlineInputBorder(),
                        hintText: "Unesite Vaš e-mail"),
                    controller: emailController,
                  ),
                  Button(
                    label: "POŠALJI KOD",
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
