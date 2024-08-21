import 'package:erezervisi_mobile/widgets/chat_custom/my_message.dart';
import 'package:erezervisi_mobile/widgets/chat_custom/other_message.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';

class ChatDetails extends StatefulWidget {
  const ChatDetails({super.key});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    return const MasterWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              OtherMessage(),
              SizedBox(
                height: 10,
              ),
              MyMessage(),
              SizedBox(
                height: 10,
              ),
              OtherMessage(),
              SizedBox(
                height: 10,
              ),
              MyMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
