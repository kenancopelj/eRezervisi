import 'package:erezervisi_desktop/models/responses/user/user_settings_get_dto.dart';

class UserGetDto {
  late num id;
  late String firstName;
  late String lastName;
  late String phone;
  late String address;
  late String email;
  late String? image;
  late String username;
  late UserSettingsGetDto settings;

  UserGetDto(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.address,
      required this.email,
      required this.username,
      this.image,
      required this.settings});

  factory UserGetDto.fromJson(Map<String, dynamic> json) {
    return UserGetDto(
        id: json['id'] as num,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        image: json['image'],
        settings: UserSettingsGetDto.fromJson(json['userSettings']));
  }
}
