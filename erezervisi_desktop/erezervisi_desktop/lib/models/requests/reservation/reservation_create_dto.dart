class ReservationCreateDto {
  late num accommodationUnitId;
  late DateTime from;
  late DateTime to;
  late String? note;
  late num numberOfAdults;
  late num numberOfChildren;
  late int paymenthMethod;

  ReservationCreateDto({
    required this.accommodationUnitId,
    required this.from,
    required this.to,
    this.note,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.paymenthMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'accommodationUnitId': accommodationUnitId,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'note': note,
      'numberOfAdults': numberOfAdults,
      'numberOfChildren': numberOfChildren,
      'paymenthMethod': paymenthMethod,
    };
  }
}
