import 'package:erezervisi_mobile/screens/chat_details.dart';
import 'package:erezervisi_mobile/screens/home.dart';
import 'package:erezervisi_mobile/widgets/chat_custom/message_preview.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const Home(),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                transitionsBuilder: (_, animation, __, child) {
                                  return FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 12,
                      )),
                  const Text(
                    "Poruke",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              MessagePreview(
                onClick: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const ChatDetails(),
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          }));
                },
              ),
              MessagePreview(
                onClick: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const ChatDetails(),
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          }));
                },
              ),
              MessagePreview(
                onClick: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const ChatDetails(),
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder: (_, animation, __, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
