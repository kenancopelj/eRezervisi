import 'package:erezervisi_mobile/models/requests/accommodation_unit/policy_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/image/image_create_dto.dart';

class AccommodationUnitCreateDto {
  late String title;
  late String shortTitle;
  late num price;
  String? note;
  late PolicyCreateDto policy;
  late num categoryId;
  late List<ImageCreateDto> files;
  late num townshipId;
  late num latitude;
  late num longitude;

  AccommodationUnitCreateDto(
      {required this.title,
      required this.shortTitle,
      required this.price,
      this.note,
      required this.policy,
      required this.categoryId,
      required this.files,
      required this.townshipId,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'shortTitle': shortTitle,
      'price': price.toString(),
      'note': note,
      'policy': policy.toJson(),
      'accommodationUnitCategoryId': categoryId,
      'files': files.map((file) => file.toJson()).toList(),
      'townshipId': townshipId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
  }
}
