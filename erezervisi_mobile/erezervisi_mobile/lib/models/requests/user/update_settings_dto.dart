class UpdateSettingsDto {
  final bool receiveMails;
  final bool receiveNotifications;

  UpdateSettingsDto({
    required this.receiveMails,
    required this.receiveNotifications,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiveMails': receiveMails,
      'receiveNotifications': receiveNotifications,
    };
  }
}
