import 'package:erezervisi_desktop/enums/button_type.dart';
import 'package:erezervisi_desktop/shared/style.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final void Function()? onClick;
  final String? label;
  final ButtonType? type;
  final IconData? icon;
  const Button({super.key, this.onClick, this.label, this.type, this.icon});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color buttonColor() {
    switch (widget.type) {
      case ButtonType.Primary:
        return Style.primaryColor100;
      case ButtonType.Link:
        return Style.linkColor;
      default:
        return Style.primaryColor100;
    }
  }

  Color textColor() {
    switch (widget.type) {
      case ButtonType.Primary:
        return Colors.white;
      case ButtonType.Link:
        return Style.primaryColor100;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 50, right: 50),
      child: InkWell(
        onTap: () async {},
        child: InkWell(
          onTap: widget.onClick,
          child: Container(
            width: w,
            height: 50, 
            decoration: BoxDecoration(
                color: buttonColor(), borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(
              widget.label ?? "",
              style: TextStyle(color: textColor()),
            )),
          ),
        ),
      ),
    );
  }
}
