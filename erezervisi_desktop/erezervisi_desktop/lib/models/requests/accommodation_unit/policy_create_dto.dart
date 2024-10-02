class PolicyCreateDto {
  late bool alcoholAllowed;
  late num capacity;
  late bool oneNightOnly;
  late bool birthdayPartiesAllowed;
  late bool hasPool;

  PolicyCreateDto(
      {required this.alcoholAllowed,
      required this.capacity,
      required this.oneNightOnly,
      required this.birthdayPartiesAllowed,
      required this.hasPool});

  Map<String, dynamic> toJson() {
    return {
      'alcoholAllowed': alcoholAllowed,
      'capacity': capacity,
      'oneNightOnly': oneNightOnly,
      'birthdayPartiesAllowed': birthdayPartiesAllowed,
      'hasPool': hasPool,
    };
  }
}
