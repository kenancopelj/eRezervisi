import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/message/message_get_dto.dart';
import 'package:flutter/material.dart';

class OtherMessage extends StatefulWidget {
  final MessageGetDto message;
  const OtherMessage({super.key, required this.message});

  @override
  State<OtherMessage> createState() => _OtherMessageState();
}

class _OtherMessageState extends State<OtherMessage> {
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
            margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width - 110,
            child: Text(
              widget.message.content,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: CustomTheme.bluePrimaryColor,
                borderRadius: BorderRadius.circular(30)),
          )
        ],
      ),
    );
  }
}
