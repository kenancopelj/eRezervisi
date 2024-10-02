import 'package:image_picker/image_picker.dart';

class ImageCreateDto {
  String? imageBase64;
  String? imageFileName;
  late bool isThumbnail;
  XFile? image;

  ImageCreateDto(
      {this.imageBase64,
      this.imageFileName,
      required this.isThumbnail,
      this.image});

  Map<String, dynamic> toJson() {
    return {
      'imageBase64': imageBase64,
      'imageFileName': imageFileName,
      'isThumbnail': isThumbnail
    };
  }
}
