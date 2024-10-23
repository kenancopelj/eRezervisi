class PaymentIntentRequest {
  late num amount;
  PaymentIntentRequest({required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}
