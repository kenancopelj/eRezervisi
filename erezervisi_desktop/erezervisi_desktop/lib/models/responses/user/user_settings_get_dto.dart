class UserSettingsGetDto {
  late num userId;
  late bool receiveEmails;
  late bool receiveNotifications;
  late bool markObjectAsUncleanAfterReservation;

  UserSettingsGetDto({
    required this.userId,
    required this.receiveEmails,
    required this.receiveNotifications,
    required this.markObjectAsUncleanAfterReservation
  });

  factory UserSettingsGetDto.fromJson(Map<String, dynamic> json) {
    return UserSettingsGetDto(
        userId: json['userId'] as num,
        receiveEmails: json['receiveEmails'],
        receiveNotifications: json['receiveNotifications'],
        markObjectAsUncleanAfterReservation: json['markObjectAsUncleanAfterReservation'],);
  }
}
