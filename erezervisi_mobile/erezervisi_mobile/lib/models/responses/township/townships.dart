import 'package:erezervisi_mobile/models/responses/township/township_get_dto.dart';

class Townships {
  late List<TownshipGetDto> townships;

  Townships({required this.townships});

  factory Townships.fromJson(Map<String, dynamic> json) {
    List<TownshipGetDto> townships =
        (json['townships'] as List<TownshipGetDto>)
            .map((townshipJson) => TownshipGetDto.fromJson(json))
            .toList();

    return Townships(townships: townships);
  }
}
