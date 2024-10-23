// shared/components/toast.dart

import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Icon icon;

  const Toast(
      {super.key,
      required this.message,
      required this.backgroundColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 85,
      right: 20,
      child: Material(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Row(
            children: [
              icon,
              SizedBox(width: 8,),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
