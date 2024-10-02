class UserSettingsGetDto {
  late num userId;
  late bool receiveMails;
  late bool receiveNotifications;

  UserSettingsGetDto({
    required this.userId,
    required this.receiveMails,
    required this.receiveNotifications,
  });

  factory UserSettingsGetDto.fromJson(Map<String, dynamic> json) {
    return UserSettingsGetDto(
        userId: json['userId'] as num,
        receiveMails: json['receiveMails'],
        receiveNotifications: json['receiveNotifications']);
  }
}
