import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/screens/reservations/reservations.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                  width: 100,
                  height: 70,
                  Globals.imageBasePath + item.accommodationUnitThumbnailImage!,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 120, child: Text(item.guest)),
              SizedBox(width: 120, child: Text(item.accommodationUnitTitle)),
              SizedBox(
                  width: 120,
                  child:
                      Text(DateFormat(Globals.dateFormat).format(item.from))),
              SizedBox(
                  width: 120,
                  child: Text(DateFormat(Globals.dateFormat).format(item.to))),
              Container(
                width: 120,
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statuses.where((element) => element.status == item.status).firstOrNull?.color ?? CustomTheme.bluePrimaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    statuses.where((element) => element.status == item.status).firstOrNull?.label.toUpperCase() ?? "N/A",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 120, child: Text("${item.totalPrice} KM")),
            ],
          ),
        ),
      ),
    );
  }
}
