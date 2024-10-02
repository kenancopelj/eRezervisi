import 'package:erezervisi_desktop/models/responses/category/category_get_dto.dart';

class Categories {
  late List<CategoryGetDto> categories;

  Categories({required this.categories});

  factory Categories.fromJson(Map<String, dynamic> json) {
    List<CategoryGetDto> categories =
        (json['categories'] as List<CategoryGetDto>)
            .map((categoryJson) => CategoryGetDto.fromJson(json))
            .toList();

    return Categories(categories: categories);
  }
}
