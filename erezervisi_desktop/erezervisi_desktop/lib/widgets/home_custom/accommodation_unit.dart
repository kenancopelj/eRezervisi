import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';

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
                  child: Image.network(
                      Globals.imageBasePath + widget.item.thumbnailImage,
                      fit: BoxFit.cover)),
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
