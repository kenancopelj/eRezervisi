import 'package:erezervisi_mobile/enums/button_type.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/responses/user/check_code_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/request_code_dto.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/screens/reset-password.dart';
import 'package:erezervisi_mobile/shared/components/form/button.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/validators/forgotten-password/request.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Verifikacija naloga",
                    style: CustomTheme.mediumTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Unesite kod koji je poslan na ${widget.email}",
                    style: CustomTheme.smallTextStyle,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    style: CustomTheme.smallTextStyle,
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
