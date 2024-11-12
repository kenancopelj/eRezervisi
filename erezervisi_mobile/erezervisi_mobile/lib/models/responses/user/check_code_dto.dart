class CheckCodeDto {
  late String email;
  late num code;

  CheckCodeDto({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code
    };
  }
}