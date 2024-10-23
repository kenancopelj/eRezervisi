import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClick;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const ActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onClick,
    this.backgroundColor = const Color.fromARGB(255, 8, 64, 109),
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(16),
      ),
      icon: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
      label: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
      ),
      onPressed: onClick,
    );
  }
}
