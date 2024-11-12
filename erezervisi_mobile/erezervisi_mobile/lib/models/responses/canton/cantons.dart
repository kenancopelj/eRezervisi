import 'package:erezervisi_mobile/models/responses/canton/canton_get_dto.dart';

class Cantons {
  late List<CantonGetDto> cantons;

  Cantons({required this.cantons});

  factory Cantons.fromJson(Map<String, dynamic> json) {
    List<CantonGetDto> cantons =
        (json['cantons'] as List<CantonGetDto>)
            .map((messageJson) => CantonGetDto.fromJson(json))
            .toList();

    return Cantons(cantons: cantons);
  }
}
