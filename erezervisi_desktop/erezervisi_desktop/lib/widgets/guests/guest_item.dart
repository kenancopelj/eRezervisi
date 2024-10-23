import 'package:erezervisi_desktop/models/responses/guest/guest_get_dto.dart';
import 'package:flutter/material.dart';

class GuestItem extends StatelessWidget {
  final GuestGetDto item;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  const GuestItem(
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
              SizedBox(width: 120, child: Text(item.fullName)),
              SizedBox(
                  width: 120,
                  child: Column(
                    children: [
                      Text(item.phone),
                      Text(item.email),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
