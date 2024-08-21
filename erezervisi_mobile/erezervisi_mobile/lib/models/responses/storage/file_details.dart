import 'dart:typed_data';

class FileDetails {
  late Uint8List bytes;
  late String fileName;
  late String contentType;

  FileDetails(
      {required this.bytes, required this.fileName, required this.contentType});

  factory FileDetails.fromJson(Map<String, dynamic> json) {
    return FileDetails(
        bytes: json['bytes'],
        fileName: json['fileName'],
        contentType: json['contentType']);
  }
}
