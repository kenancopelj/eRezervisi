import 'package:erezervisi_desktop/models/responses/category/category_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/image/image_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/policy/policy_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/township/township_get_dto.dart';

class AccommodationUnitGetDto {
  late num id;
  late String title;
  late num price;
  late String? note;
  late String address;
  late PolicyGetDto? policy;
  late num categoryId;
  late CategoryGetDto? category;
  late num townshipId;
  late TownshipGetDto township;
  late num latitude;
  late num longitude;
  late num tapPosition;
  late String thumbnailImage;
  late List<ImageGetDto> images;
  late bool favorite;
  late num ownerId;

  AccommodationUnitGetDto(
      {required this.id,
      required this.title,
      required this.price,
      this.note,
      required this.address,
      required this.policy,
      required this.category,
      required this.categoryId,
      required this.townshipId,
      required this.township,
      required this.latitude,
      required this.longitude,
      required this.tapPosition,
      required this.thumbnailImage,
      required this.images,
      required this.favorite,
      required this.ownerId});

  factory AccommodationUnitGetDto.fromJson(Map<String, dynamic> json) {
    return AccommodationUnitGetDto(
        id: json['id'] as num,
        title: json['title'],
        address: json['address'],
        price: json['price'] as num,
        policy: json['accommodationUnitPolicy'] != null
            ? PolicyGetDto.fromJson(json['accommodationUnitPolicy'])
            : null,
        categoryId: json['accommodationUnitCategoryId'] as num,
        townshipId: json['townshipId'] as num,
        category: json['category'] != null
            ? CategoryGetDto.fromJson(json['accommodationUnitCategory'])
            : null,
        township: TownshipGetDto.fromJson(json['township']),
        latitude: json['latitude'] as num,
        longitude: json['longitude'] as num,
        tapPosition: json['tapPosition'] as num,
        thumbnailImage: json['thumbnailImage'],
        favorite: json['favorite'],
        ownerId: json['ownerId'] as num,
        images: (json['images'] as List<dynamic>)
            .map((imageJson) => ImageGetDto.fromJson(imageJson))
            .toList());
  }
}
