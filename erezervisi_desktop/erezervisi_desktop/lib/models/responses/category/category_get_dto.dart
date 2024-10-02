class CategoryGetDto {
  late num id;
  late String title;

  CategoryGetDto({required this.id, required this.title});

  factory CategoryGetDto.fromJson(Map<String, dynamic> json) {
    return CategoryGetDto(
        id: json['id'] as num, title: json['title'] as String);
  }
}
