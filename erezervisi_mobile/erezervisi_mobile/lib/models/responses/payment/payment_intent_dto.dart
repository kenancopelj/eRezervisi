class PaymentIntentDto {
  String? id;
  String? clientSecret;

  PaymentIntentDto({
    this.id,
    this.clientSecret,
  });

  factory PaymentIntentDto.fromJson(Map<String, dynamic> json) {
    return PaymentIntentDto(
      id: json['id'],
      clientSecret: json['clientSecret'],
    );
  }
}
