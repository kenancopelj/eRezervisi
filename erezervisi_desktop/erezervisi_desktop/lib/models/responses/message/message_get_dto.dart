import 'package:erezervisi_desktop/models/responses/user/user_get_short_dto.dart';

class MessageGetDto {
  late num id;
  late num receiverId;
  late UserGetShortDto receiver;
  late num senderId;
  late UserGetShortDto sender;
  late String content;

  MessageGetDto(
      {required this.id,
      required this.receiverId,
      required this.receiver,
      required this.sender,
      required this.senderId,
      required this.content});

  factory MessageGetDto.fromJson(Map<String, dynamic> json) {
    return MessageGetDto(
        id: json['id'] as num,
        receiverId: json['receiverId'] as num,
        receiver: UserGetShortDto.fromJson(json['receiver']),
        senderId: json['senderId'] as num,
        sender: UserGetShortDto.fromJson(json['sender']),
        content: json['content']);
  }
}
