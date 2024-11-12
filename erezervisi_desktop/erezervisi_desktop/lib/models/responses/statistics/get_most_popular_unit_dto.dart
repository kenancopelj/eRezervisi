import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';

class GetMostPopularUnitDto {
  late AccommodationUnitGetDto accommodationUnit;
  late num numberOfReservations;

  GetMostPopularUnitDto(
      {required this.accommodationUnit, required this.numberOfReservations});

  GetMostPopularUnitDto.def();

  factory GetMostPopularUnitDto.fromJson(Map<String, dynamic> json) {
    return GetMostPopularUnitDto(
        accommodationUnit:
            AccommodationUnitGetDto.fromJson(json['accommodationUnit']),
        numberOfReservations: json['numberOfReservations']);
  }
}
