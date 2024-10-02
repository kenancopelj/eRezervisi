import 'package:erezervisi_desktop/models/responses/category/category_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/image/image_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/policy/policy_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/township/township_get_dto.dart';

class AccommodationUnitGetDto {
  late num id;
  late String title;
  late num price;
  late String? note;
  late PolicyGetDto? policy;
  late CategoryGetDto? category;
  late TownshipGetDto township;
  late num latitude;
  late num longitude;
  late String thumbnailImage;
  late List<ImageGetDto> images;
  late bool favorite;
  late num ownerId;

  AccommodationUnitGetDto(
      {required this.id,
      required this.title,
      required this.price,
      this.note,
      required this.policy,
      required this.category,
      required this.township,
      required this.latitude,
      required this.longitude,
      required this.thumbnailImage,
      required this.images,
      required this.favorite,
      required this.ownerId});

  factory AccommodationUnitGetDto.fromJson(Map<String, dynamic> json) {
    return AccommodationUnitGetDto(
        id: json['id'] as num,
        title: json['title'],
        price: json['price'] as num,
        policy: json['accommodationUnitPolicy'] != null
            ? PolicyGetDto.fromJson(json['accommodationUnitPolicy'])
            : null,
        category: json['category'] != null
            ? CategoryGetDto.fromJson(json['accommodationUnitCategory'])
            : null,
        township: TownshipGetDto.fromJson(json['township']),
        latitude: json['latitude'] as num,
        longitude: json['longitude'] as num,
        thumbnailImage: json['thumbnailImage'],
        favorite: json['favorite'],
        ownerId: json['ownerId'] as num,
        images: (json['images'] as List<dynamic>)
            .map((imageJson) => ImageGetDto.fromJson(imageJson))
            .toList());
  }
}
