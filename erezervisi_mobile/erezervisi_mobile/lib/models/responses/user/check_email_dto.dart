class CheckEmailDto {
  num? userId;
  late String email;

  CheckEmailDto({this.userId, required this.email});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'email': email};
  }
}
