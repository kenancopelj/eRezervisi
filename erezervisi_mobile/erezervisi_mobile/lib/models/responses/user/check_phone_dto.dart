class CheckPhoneDto {
  num? userId;
  late String phoneNumber;

  CheckPhoneDto({this.userId, required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'phoneNumber': phoneNumber};
  }
}
