class CantonGetDto {
  late num id;
  late String title;
  late String shortTitle;

  CantonGetDto(
      {required this.id, required this.title, required this.shortTitle});

  factory CantonGetDto.fromJson(Map<String, dynamic> json) {
    return CantonGetDto(
        id: json['id'] as num,
        title: json['title'] as String,
        shortTitle: json['shortTitle'] as String);
  }
}
