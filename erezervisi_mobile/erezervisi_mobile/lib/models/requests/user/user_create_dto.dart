class UserCreateDto {
  String firstName;
  String lastName;
  String phone;
  String address;
  String email;
  String username;
  String password;

  UserCreateDto({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'email': email,
      'username': username,
      'password': password
    };
  }
}
