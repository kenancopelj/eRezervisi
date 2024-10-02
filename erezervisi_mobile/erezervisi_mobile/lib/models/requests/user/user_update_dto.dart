class UserUpdateDto {
  String firstName;
  String lastName;
  String phone;
  String address;
  String email;
  String? imageBase64;
  String? imageFileName;
  String username;
  String? newPassword;

  UserUpdateDto({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.email,
    this.imageBase64,
    this.imageFileName,
    required this.username,
    this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'email': email,
      'imageBase64': imageBase64,
      'imageFileName': imageFileName,
      'username': username,
      'newPassword': newPassword
    };
  }
}
