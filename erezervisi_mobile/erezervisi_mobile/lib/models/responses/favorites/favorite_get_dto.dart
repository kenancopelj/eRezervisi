import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';

class FavoriteGetDto {
  late num id;
  late num accommodationUnitId;
  late AccommodationUnitGetDto accommodationUnitGetDto;

  FavoriteGetDto(
      {required this.id,
      required this.accommodationUnitId,
      required this.accommodationUnitGetDto});

  factory FavoriteGetDto.fromJson(Map<String, dynamic> json) {
    return FavoriteGetDto(
        id: json['id'] as num,
        accommodationUnitId: json['accommodationUnitId'] as num,
        accommodationUnitGetDto:
            AccommodationUnitGetDto.fromJson(json['accommodationUnit']));
  }
}
