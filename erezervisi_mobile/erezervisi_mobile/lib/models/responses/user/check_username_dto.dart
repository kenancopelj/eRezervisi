class CheckUsernameDto {
  num? userId;
  late String username;

  CheckUsernameDto({this.userId, required this.username});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'username': username};
  }
}
