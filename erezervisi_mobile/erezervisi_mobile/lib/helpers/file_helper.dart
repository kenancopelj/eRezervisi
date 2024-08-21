import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile> getXFileFromBytes(Uint8List bytes, String fileName) async {
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);
  await file.writeAsBytes(bytes);
  return XFile(filePath);
}
