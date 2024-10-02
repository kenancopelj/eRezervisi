import 'dart:io';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/helpers/file_helper.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/providers/file_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_unit_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AccommodationUnit extends StatefulWidget {
  final AccommodationUnitGetDto item;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  const AccommodationUnit(
      {super.key,
      required this.item,
      required this.isSelected,
      required this.onSelected});

  @override
  State<AccommodationUnit> createState() => _AccommodationUnitState();
}

class _AccommodationUnitState extends State<AccommodationUnit> {
  late FileProvider fileProvider;
  XFile? image;

  @override
  void initState() {
    super.initState();

    fileProvider = context.read<FileProvider>();

    loadImage();
  }

  Future loadImage() async {
    var response = await fileProvider
        .downloadAccommodationUnitImage(widget.item.thumbnailImage);
    var xfile = await getXFileFromBytes(response.bytes, response.fileName);

    setState(() {
      image = xfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 80,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
                child: Checkbox(
                  value: widget.isSelected,
                  onChanged: widget.onSelected,
                ),
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: image != null
                    ? Image.file(File(image!.path), fit: BoxFit.cover)
                    : const Icon(Icons.image, size: 60, color: Colors.grey),
              ),
              SizedBox(width: 120, child: Text(widget.item.title)),
              SizedBox(width: 120, child: Text(widget.item.township.title)),
              SizedBox(
                  width: 120,
                  child: Text("${widget.item.price.toStringAsFixed(2)} KM")),
            ],
          ),
        ),
      ),
    );
  }
}
