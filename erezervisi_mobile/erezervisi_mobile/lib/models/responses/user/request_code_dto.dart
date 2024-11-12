class RequestCodeDto {
  late String email;

  RequestCodeDto({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email
    };
  }
}