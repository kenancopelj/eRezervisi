import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PreviewImage extends StatelessWidget {
  XFile? image;
  String? imageUrl;

  PreviewImage({super.key, this.image, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          if (image != null)
            Image.file(
              File(image!.path),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
            ),
          if (imageUrl != null)
            Image.network(
              imageUrl!,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
            ),
          Positioned(
            top: -10,
            right: 0,
            child: IconButton(
              splashRadius: 1,
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
