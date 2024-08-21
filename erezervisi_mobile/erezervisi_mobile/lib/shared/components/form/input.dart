import 'package:erezervisi_mobile/enums/input_type.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? hintText;
  final InputType? type;
  final bool? rounded;
  final Icon? suffixIcon;

  const Input(
      {super.key,
      this.type,
      required this.controller,
      this.label,
      this.validator,
      this.obscureText,
      this.hintText,
      this.rounded,
      this.suffixIcon});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscure = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      obscure = widget.obscureText ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.label ?? "",
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: keyboardType(),
              validator: widget.validator,
              obscureText: obscure,
              style: const TextStyle(
                fontSize: 12,
              ),
              controller: widget.controller,
              decoration: InputDecoration(
                  suffixIcon:
                      widget.obscureText != null && widget.obscureText == true
                          ? IconButton(
                              icon: obscure
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: handleTextObscurity,
                            )
                          : widget.suffixIcon,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal:
                          widget.rounded != null && widget.rounded! ? 10 : 0),
                  hintText: widget.hintText ?? "",
                  hintStyle: TextStyle(color: Style.borderColor),
                  border: widget.rounded != null && widget.rounded!
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Style.borderColor, width: 0.5))
                      : UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Style.borderColor, width: 1.0))),
            )
          ],
        ),
      )
    ]);
  }

  TextInputType keyboardType() {
    switch (widget.type) {
      case InputType.Text:
        return TextInputType.text;
      case InputType.Number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  handleTextObscurity() {
    setState(() {
      obscure = !obscure;
    });
  }
}
