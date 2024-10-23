import 'package:erezervisi_desktop/models/requests/accommodation_unit/policy_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/image/image_create_dto.dart';

class AccommodationUnitUpdateDto {
  late num id;
  late String title;
  late num price;
  String? note;
  late PolicyCreateDto policy;
  late num categoryId;
  late List<ImageCreateDto> files;
  late num townshipId;
  late num latitude;
  late num longitude;
  late String address;

  AccommodationUnitUpdateDto(
      {required this.id,
      required this.title,
      required this.price,
      this.note,
      required this.policy,
      required this.categoryId,
      required this.files,
      required this.townshipId,
      required this.latitude,
      required this.longitude,
      required this.address});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'note': note,
      'policy': policy.toJson(),
      'accommodationUnitCategoryId': categoryId,
      'files': files.map((file) => file.toJson()).toList(),
      'townshipId': townshipId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'address': address
    };
  }
}
