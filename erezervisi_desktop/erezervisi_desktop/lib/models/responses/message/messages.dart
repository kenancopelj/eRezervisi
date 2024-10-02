import 'package:erezervisi_desktop/models/responses/message/message_get_dto.dart';

class Messages {
  late List<MessageGetDto> messages;

  Messages({required this.messages});

  factory Messages.fromJson(Map<String, dynamic> json) {
    List<MessageGetDto> messages =
        (json['messages'] as List<MessageGetDto>)
            .map((messageJson) => MessageGetDto.fromJson(json))
            .toList();

    return Messages(messages: messages);
  }
}
