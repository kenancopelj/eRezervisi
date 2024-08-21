class PolicyGetDto {
  late bool alcoholAllowed;
  late num capacity;
  late bool oneNightOnly;
  late bool birthdayPartiesAllowed;
  late bool hasPool;

  PolicyGetDto(
      {required this.alcoholAllowed,
      required this.capacity,
      required this.oneNightOnly,
      required this.birthdayPartiesAllowed,
      required this.hasPool});

  factory PolicyGetDto.fromJson(Map<String, dynamic> json) {
    return PolicyGetDto(
        alcoholAllowed: json['alcoholAllowed'] as bool,
        capacity: json['capacity'] as num,
        oneNightOnly: json['oneNightOnly'] as bool,
        birthdayPartiesAllowed: json['birthdayPartiesAllowed'] as bool,
        hasPool: json['hasPool'] as bool);
  }
}
