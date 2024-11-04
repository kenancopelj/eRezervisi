class UserSettingsGetDto {
  late num userId;
  late bool receiveEmails;
  late bool receiveNotifications;

  UserSettingsGetDto({
    required this.userId,
    required this.receiveEmails,
    required this.receiveNotifications,
  });

  factory UserSettingsGetDto.fromJson(Map<String, dynamic> json) {
    return UserSettingsGetDto(
        userId: json['userId'] as num,
        receiveEmails: json['receiveEmails'],
        receiveNotifications: json['receiveNotifications']);
  }
}
