class ResetPasswordDto {
  late String email;
  late String newPassword;

  ResetPasswordDto({required this.email, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {'email': email, 'newPassword': newPassword};
  }
}
