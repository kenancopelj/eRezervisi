class AccommodationUnitGetShortDto {
  late num id;
  late String title;
  late String image;

  AccommodationUnitGetShortDto({
    required this.id,
    required this.title,
    required this.image,
  });

  factory AccommodationUnitGetShortDto.fromJson(Map<String, dynamic> json) {
    return AccommodationUnitGetShortDto(
      id: json['id'] as num,
      title: json['title'],
      image: json['image'],
    );
  }
}
