import 'package:erezervisi_desktop/enums/button_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/user/check_code_dto.dart';
import 'package:erezervisi_desktop/models/responses/user/request_code_dto.dart';
import 'package:erezervisi_desktop/providers/user_provider.dart';
import 'package:erezervisi_desktop/screens/forgotten-password/reset-password.dart';
import 'package:erezervisi_desktop/shared/components/form/button.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/shared/validators/forgotten-password/request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CheckCodeScreen extends StatefulWidget {
  final String email;
  const CheckCodeScreen({required this.email, super.key});

  @override
  State<CheckCodeScreen> createState() => _CheckCodeScreenState();
}

class _CheckCodeScreenState extends State<CheckCodeScreen> {
  var codeController = TextEditingController();

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

    var response = await userProvider.checkForgottenPasswordCode(CheckCodeDto(
        email: widget.email, code: num.parse(codeController.text)));

    if (response && mounted) {
      Navigate.next(context, AppRoutes.resetPassword.routeName,
          ResetPasswordScreen(email: widget.email), true);
    }
  }

  Future requestCode() async {
    await userProvider
        .requestForgottenPasswordCode(RequestCodeDto(email: widget.email));
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
                    "Unesite kod koji Vam je poslan na mail",
                    style: CustomTheme.mediumTextStyle,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Obavezno polje\n';
                      } else if (value.length < 6) {
                        return 'Unesite 6 cifri\n';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text("Kod"),
                        border: OutlineInputBorder(),
                        hintText: "Unesite Vaš kod"),
                    controller: codeController,
                  ),
                  Button(
                    label: "POTVRDI",
                    onClick: handleSubmit,
                  ),
                  Button(
                    label: "Pošalji ponovo",
                    type: ButtonType.Link,
                    onClick: requestCode,
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
