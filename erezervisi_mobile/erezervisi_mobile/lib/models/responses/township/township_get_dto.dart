import 'package:erezervisi_mobile/models/responses/canton/canton_get_dto.dart';

class TownshipGetDto {
  late num id;
  late String title;
  late num cantonId;
  late CantonGetDto canton;

  TownshipGetDto(
      {required this.id,
      required this.title,
      required this.cantonId,
      required this.canton});

  factory TownshipGetDto.fromJson(Map<String, dynamic> json) {
    return TownshipGetDto(
        id: json['id'] as num,
        title: json['title'] as String,
        cantonId: json['cantonId'] as num,
        canton: CantonGetDto.fromJson(json['canton']));
  }
}
