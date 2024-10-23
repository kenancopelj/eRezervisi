import 'package:erezervisi_desktop/models/requests/accommodation_unit/policy_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/image/image_create_dto.dart';

class AccommodationUnitCreateDto {
  late String title;
  late num price;
  late String address;
  String? note;
  late PolicyCreateDto policy;
  late num categoryId;
  late List<ImageCreateDto> files;
  late num townshipId;
  late num latitude;
  late num longitude;

  AccommodationUnitCreateDto(
      {required this.title,
      required this.price,
      required this.address,
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
      'price': price,
      'address': address,
      'note': note,
      'policy': policy.toJson(),
      'accommodationUnitCategoryId': categoryId,
      'files': files.map((file) => file.toJson()).toList(),
      'townshipId': townshipId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
