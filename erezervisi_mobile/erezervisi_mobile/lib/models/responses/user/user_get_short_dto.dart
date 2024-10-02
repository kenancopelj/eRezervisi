class UserGetShortDto {
  late num id;
  late String fullName;
  late String? image;
  String? initials;

  UserGetShortDto(
      {required this.id, required this.fullName, this.image, this.initials});

  factory UserGetShortDto.fromJson(Map<String, dynamic> json) {
    return UserGetShortDto(
        id: json['id'] as num,
        fullName: json['fullName'] as String,
        image: json['image'],
        initials: json['initials']);
  }
}
