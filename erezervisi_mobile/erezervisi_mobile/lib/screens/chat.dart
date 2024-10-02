import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/message/get_messages_request.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/message/message_get_dto.dart';
import 'package:erezervisi_mobile/providers/message_provider.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_details.dart'; // Import your ChatDetails screen

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  late MessageProvider messageProvider;

  var request = GetMessagesRequest.def();
  var messages = PagedResponse<MessageGetDto>.empty();

  @override
  void initState() {
    super.initState();
    messageProvider = context.read<MessageProvider>();
    loadConversations();
  }

  Future loadConversations() async {
    var response = await messageProvider.getPaged(request);

    if (mounted) {
      setState(() {
        messages = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 12,
                  ),
                ),
                Text(
                  "Razgovori",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            messages.items.isEmpty
                ? Expanded(child: Center(child: Text("Nemate novih razgovora")))
                : Expanded(
                    child: ListView.builder(
                      itemCount: messages.items.length,
                      itemBuilder: (context, index) {
                        var message = messages.items[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatDetails(userId: message.senderId),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              title: Text(
                                message.sender.fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                message.content,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.blue,
                              ),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
