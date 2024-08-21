class UserGetDto {
  late num id;
  late String firstName;
  late String lastName;
  late String phone;
  late String address;
  late String email;
  late String? image;

  UserGetDto(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.address,
      required this.email,
      this.image});

  factory UserGetDto.fromJson(Map<String, dynamic> json) {
    return UserGetDto(
        id: json['id'] as num,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        email: json['email'] as String,
        image: json['image']);
  }
}
