class MessageCreateDto {
  late num receiverId;
  late String content;
  MessageCreateDto({required this.receiverId, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'content': content,
    };
  }
}
