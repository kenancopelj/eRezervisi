import 'dart:io';

import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/helpers/file_helper.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/providers/file_provider.dart';
import 'package:erezervisi_mobile/screens/accommodation_unit_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget {
  final AccommodationUnitGetDto item;
  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ObjectDetails(
                      accommodationUnitId: widget.item.id,
                    )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 2.0,
        child: Container(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 12),
                    child: SizedBox(
                      height: 168,
                      width: 224,
                      child: image != null
                          ? Image.file(File(image!.path))
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.item.title,
                    style: CustomTheme.largeTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.item.township.title,
                      style: const TextStyle(color: Colors.black))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.item.note ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${widget.item.price}KM",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Spacer(),
                  const Icon(Icons.favorite_outline),
                  const SizedBox(
                    width: 15,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
