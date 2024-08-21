import 'package:image_picker/image_picker.dart';

class ImageCreateDto {
  late String imageBase64;
  late String imageFileName;
  late bool isThumbnail;
  XFile? image;

  ImageCreateDto(
      {required this.imageBase64,
      required this.imageFileName,
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
