import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_short_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_short_dto.dart';

class SearchResponse {
  late List<AccommodationUnitGetShortDto> accommodationUnits;
  late List<UserGetShortDto> users;

  SearchResponse({required this.accommodationUnits, required this.users});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<AccommodationUnitGetShortDto> accommodationUnits =
        (json['accommodationUnits'] as List<AccommodationUnitGetShortDto>)
            .map((item) => AccommodationUnitGetShortDto.fromJson(json))
            .toList();

    List<UserGetShortDto> users = (json['users'] as List<UserGetShortDto>)
        .map((item) => UserGetShortDto.fromJson(json))
        .toList();

    return SearchResponse(accommodationUnits: accommodationUnits, users: users);
  }
}
