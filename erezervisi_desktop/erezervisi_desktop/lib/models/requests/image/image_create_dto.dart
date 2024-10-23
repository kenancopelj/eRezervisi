import 'package:image_picker/image_picker.dart';

class ImageCreateDto {
  num? id;
  String? imageBase64;
  String? imageFileName;
  XFile? image;
  String? imageUrl;
  late bool isThumbnail;
  bool delete;

  ImageCreateDto(
      {this.id,
      this.imageBase64,
      this.imageFileName,
      required this.isThumbnail,
      this.imageUrl,
      this.image,
      this.delete = false});

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'imageBase64': imageBase64,
      'imageFileName': imageFileName,
      'isThumbnail': isThumbnail,
      'delete': delete
    };
  }
}
