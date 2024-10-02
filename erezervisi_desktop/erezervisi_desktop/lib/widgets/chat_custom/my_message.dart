import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/message/message_get_dto.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatefulWidget {
  final MessageGetDto message;
  const MyMessage({super.key, required this.message});

  @override
  State<MyMessage> createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 75,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: CustomTheme.bluePrimaryColor,
                borderRadius: BorderRadius.circular(30)),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width - 120,
            child: Text(
              widget.message.content,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
