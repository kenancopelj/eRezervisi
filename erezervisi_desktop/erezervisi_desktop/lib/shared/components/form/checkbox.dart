import 'package:erezervisi_desktop/shared/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormSwitch extends StatefulWidget {
  bool value;
  final void Function(bool value) onChange;
  String label;
  FormSwitch(
      {super.key,
      required this.value,
      required this.onChange,
      required this.label});

  @override
  State<FormSwitch> createState() => FormSwitchState();
}

class FormSwitchState extends State<FormSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 14, color: Style.primaryColor100),
          ),
          SizedBox(
            height: 32,
            width: 16,
            child: Switch(
                value: widget.value,
                activeColor: switchColor(),
                onChanged: widget.onChange),
          ),
        ],
      ),
    );
  }

  handleRememberMeChange(newValue) {
    setState(() {
      widget.value = !widget.value;
    });
  }

  Color switchColor() {
    if (widget.value) {
      return Style.primaryColor100;
    }
    return Colors.white;
  }
}
