class GetGuestsByYearDto {
  late num month;
  late num totalGuests;

  GetGuestsByYearDto({required this.month, required this.totalGuests});

  factory GetGuestsByYearDto.fromJson(Map<String, dynamic> json) {
    return GetGuestsByYearDto(
        month: json['month'] as num, totalGuests: json['totalGuests'] as num);
  }
}
