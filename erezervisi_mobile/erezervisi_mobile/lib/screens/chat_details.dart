import 'package:erezervisi_mobile/constants/topics.dart';
import 'package:erezervisi_mobile/models/requests/message/message_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/message/messages.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/providers/message_provider.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ChatDetails extends StatefulWidget {
  final num userId;
  const ChatDetails({super.key, required this.userId});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  late UserProvider userProvider;
  UserGetDto? user;
  late MessageProvider messageProvider;
  Messages messages = Messages(messages: []);
  final TextEditingController _messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Future runSignalR() async {
    final connection = HubConnectionBuilder()
        .withUrl("${Globals.apiUrl}message-hub",
            options: HttpConnectionOptions(
              accessTokenFactory: () async => Globals.loggedUser!.token,
            ))
        .build();

    await connection.start();
    connection
        .on('${Topics.message}#${Globals.loggedUser!.userId}#${widget.userId}',
            (arguments) {
      loadMessages();
    });

    connection
        .on('${Topics.message}#${widget.userId}#${Globals.loggedUser!.userId}',
            (arguments) {
      loadMessages();
    });
  }

  Future loadMessages() async {
    var response = await messageProvider.getConversation(widget.userId);

    if (mounted) {
      setState(() {
        messages = response;
      });
    }

    scrollToBottom();
  }

  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();
    messageProvider = context.read<MessageProvider>();

    loadUser();
    loadMessages();

    runSignalR();
  }

  Future loadUser() async {
    var response = await userProvider.getById(widget.userId);

    if (mounted) {
      setState(() {
        user = response;
      });
    }
  }

  void sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      await messageProvider.send(MessageCreateDto(
          receiverId: widget.userId, content: _messageController.text));

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 15),
                  child: user == null
                      ? const Text('')
                      : Text(
                          "${user?.firstName} ${user?.lastName}",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                ),
                const SizedBox(width: 60),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.messages.length,
                itemBuilder: (context, index) {
                  var message = messages.messages[index];
                  bool isMine = message.receiverId == widget.userId;
                  return Align(
                    alignment:
                        isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMine ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message.content,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Napiši poruku...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
