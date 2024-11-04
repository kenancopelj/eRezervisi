class GuestGetDto {
  late num id;
  late String fullName;
  late String phone;
  late String email;
  String? accommodationUnitTitle;
  String? review;

  GuestGetDto(
      {required this.id,
      required this.fullName,
      required this.phone,
      required this.email,
      this.accommodationUnitTitle,
      this.review});

  factory GuestGetDto.fromJson(Map<String, dynamic> json) {
    return GuestGetDto(
      id: json['id'] as num,
      fullName: json['fullName'],
      phone: json['phone'],
      email: json['email'],
      accommodationUnitTitle: json['accommodationUnitTitle'],
    );
  }
}
