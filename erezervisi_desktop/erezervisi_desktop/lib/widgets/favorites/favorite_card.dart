import 'dart:io';

import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/helpers/file_helper.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/providers/file_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FavoriteCard extends StatefulWidget {
  final AccommodationUnitGetDto accommodationUnit;

  const FavoriteCard({super.key, required this.accommodationUnit});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  late FileProvider fileProvider;
  XFile? image;

  @override
  void initState() {
    super.initState();

    fileProvider = context.read<FileProvider>();

    loadImage();
  }

  Future loadImage() async {
    var response = await fileProvider.downloadAccommodationUnitImage(
        widget.accommodationUnit.thumbnailImage);
    var xfile = await getXFileFromBytes(response.bytes, response.fileName);

    setState(() {
      image = xfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
            color: Color.fromARGB(252, 240, 240, 240),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: image != null
                  ? Image.file(File(image!.path))
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.accommodationUnit.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.accommodationUnit.township.title,
                        style: CustomTheme.smallTextStyle)
                  ],
                ),
                Text(
                  widget.accommodationUnit.note ?? '',
                  style: CustomTheme.smallTextStyle,
                ),
                Text(
                  "${widget.accommodationUnit.price}KM",
                  style: CustomTheme.smallTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
