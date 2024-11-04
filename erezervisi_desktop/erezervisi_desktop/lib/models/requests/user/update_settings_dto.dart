class UpdateSettingsDto {
  final bool receiveEmails;
  final bool receiveNotifications;
  final bool markObjectAsUncleanAfterReservation;

  UpdateSettingsDto(
      {required this.receiveEmails,
      required this.receiveNotifications,
      required this.markObjectAsUncleanAfterReservation});

  Map<String, dynamic> toJson() {
    return {
      'receiveEmails': receiveEmails,
      'receiveNotifications': receiveNotifications,
      'markObjectAsUncleanAfterReservation': markObjectAsUncleanAfterReservation
    };
  }
}
