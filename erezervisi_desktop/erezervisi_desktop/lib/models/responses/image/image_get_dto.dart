class ImageGetDto {
  late num id;
  late String fileName;

  ImageGetDto({required this.id, required this.fileName});

  factory ImageGetDto.fromJson(Map<String, dynamic> json) {
    return ImageGetDto(
        id: json['id'] as num, fileName: json['fileName'] as String);
  }
}
