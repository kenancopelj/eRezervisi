class ReservationUpdateDto {
  late num numberOfAdults;
  late num numberOfChildren;
  late DateTime from;
  late DateTime to;
  late String? note;

  ReservationUpdateDto({
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.from,
    required this.to,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'numberOfAdults': numberOfAdults,
      'numberOfChildren': numberOfChildren,
      'from': from,
      'to': to,
      'note': note,
    };
  }
}
