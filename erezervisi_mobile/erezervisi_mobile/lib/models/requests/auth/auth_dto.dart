class AuthDto {
  String username;
  String password;
  final num scope = 2;

  AuthDto({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password, 'scope': scope};
  }
}
