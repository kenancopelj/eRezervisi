class CheckAvailability {
  late DateTime from;
  late DateTime to;

  CheckAvailability({required this.from, required this.to});

  Map<String, dynamic> toJson() {
    return {'from': from.toIso8601String(), 'to': to.toIso8601String()};
  }
}
