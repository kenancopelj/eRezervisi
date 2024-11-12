import 'dart:convert';

import 'package:erezervisi_desktop/constants/topics.dart';
import 'package:erezervisi_desktop/helpers/helpers.dart';
import 'package:erezervisi_desktop/models/requests/message/get_messages_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/message/message_get_dto.dart';
import 'package:erezervisi_desktop/providers/message_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'chat_details.dart';

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

    runSignalR();
  }

  Future runSignalR() async {
    final connection = HubConnectionBuilder()
        .withUrl("${Globals.apiUrl}message-hub",
            options: HttpConnectionOptions(
              accessTokenFactory: () async => Globals.loggedUser!.token,
            ))
        .build();

    await connection.start();

    connection.on('${Topics.conversation}#${Globals.loggedUser!.userId}',
        (arguments) {
      loadConversations();
    });
  }

  Future loadConversations() async {
    request.orderByColumn = "createdAt";
    request.orderBy = "desc";

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
                const Text(
                  "Razgovori",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            messages.items.isEmpty
                ? const Expanded(
                    child: Center(child: Text("Nemate novih razgovora")))
                : Expanded(
                    child: ListView.builder(
                      itemCount: messages.items.length,
                      itemBuilder: (context, index) {
                        var message = messages.items[index];

                        return GestureDetector(
                          onTap: () {
                            Navigate.next(context, AppRoutes.reviews.routeName,
                                ChatDetails(userId: message.senderId), true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              minTileHeight: 60,
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
                              leading: message.receiver.image != null
                                  ? SizedBox(
                                      width: 50,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(Globals
                                                        .imageBasePath +
                                                    message.receiver.image!))),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 50,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          Helpers.getInitials(
                                              message.sender.fullName),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
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
