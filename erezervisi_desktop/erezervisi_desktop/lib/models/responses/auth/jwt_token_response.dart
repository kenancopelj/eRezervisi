class JwtTokenResponse {
  final bool loggedIn;
  final String token;
  final DateTime expiresAtUtc;
  final String refreshToken;
  final DateTime refreshTokenExpiresAtUtc;
  final num roleId;
  final String firstName;
  final String lastName;
  final String initials;
  final String email;
  final String username;
  String? image;
  final num userId;
  final bool receiveNotifications;

  JwtTokenResponse(
      {required this.loggedIn,
      required this.token,
      required this.expiresAtUtc,
      required this.refreshToken,
      required this.refreshTokenExpiresAtUtc,
      required this.roleId,
      required this.firstName,
      required this.lastName,
      required this.initials,
      required this.email,
      required this.username,
      this.image,
      required this.userId,
      required this.receiveNotifications});

  factory JwtTokenResponse.fromJson(Map<String, dynamic> json) {
    return JwtTokenResponse(
        loggedIn: json['loggedIn'] ?? false,
        token: json['token'] ?? '',
        expiresAtUtc: DateTime.parse(json['expiresAtUtc']),
        refreshToken: json['refreshToken'] ?? '',
        refreshTokenExpiresAtUtc:
            DateTime.parse(json['refreshTokenExpiresAtUtc']),
        roleId: json['roleId'] ?? 0,
        firstName: json['firstName'] ?? '',
        lastName: json['lastname'] ?? '',
        initials: json['initials'] ?? '',
        email: json['email'] ?? '',
        username: json['username'] ?? '',
        image: json['image'],
        receiveNotifications: json['receiveNotifications'],
        userId: json['userId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'loggedIn': loggedIn,
      'token': token,
      'expiresAtUtc': expiresAtUtc.toIso8601String(),
      'refreshToken': refreshToken,
      'refreshTokenExpiresAtUtc': refreshTokenExpiresAtUtc.toIso8601String(),
      'roleId': roleId,
      'firstName': firstName,
      'lastName': lastName,
      'initials': initials,
      'email': email,
      'image': image,
      'username': username,
      'receiveNotifications': receiveNotifications,
      'userId': userId
    };
  }
}
