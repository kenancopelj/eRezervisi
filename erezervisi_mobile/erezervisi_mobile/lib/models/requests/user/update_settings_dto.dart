class UpdateSettingsDto {
  final bool receiveEmails;
  final bool receiveNotifications;

  UpdateSettingsDto({
    required this.receiveEmails,
    required this.receiveNotifications,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiveEmails': receiveEmails,
      'receiveNotifications': receiveNotifications,
    };
  }
}
