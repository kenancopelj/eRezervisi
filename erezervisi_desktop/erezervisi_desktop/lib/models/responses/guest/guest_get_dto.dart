class GuestGetDto {
  late num id;
  late String fullName;
  late String phone;
  late String email;

  GuestGetDto(
      {required this.id,
      required this.fullName,
      required this.phone,
      required this.email});

  factory GuestGetDto.fromJson(Map<String, dynamic> json) {
    return GuestGetDto(
        id: json['id'] as num,
        fullName: json['fullName'],
        phone: json['phone'],
        email: json['email']);
  }
}
