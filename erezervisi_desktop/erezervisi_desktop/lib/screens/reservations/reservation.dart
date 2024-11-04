import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';

class ReservationItem extends StatelessWidget {
  final ReservationGetDto item;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  const ReservationItem(
      {super.key,
      required this.item,
      required this.isSelected,
      required this.onSelected});

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
                  value: isSelected,
                  onChanged: onSelected,
                ),
              ),
              if (item.accommodationUnitThumbnailImage != null)
                Image.network(
                  Globals.imageBasePath + item.accommodationUnitThumbnailImage!,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 120, child: Text(item.guest)),
              SizedBox(width: 120, child: Text(item.accommodationUnitTitle)),
              SizedBox(width: 120, child: Text(item.from.toString())),
              SizedBox(width: 120, child: Text(item.to.toString())),
              SizedBox(width: 120, child: Text("${item.totalPrice} KM")),
            ],
          ),
        ),
      ),
    );
  }
}
