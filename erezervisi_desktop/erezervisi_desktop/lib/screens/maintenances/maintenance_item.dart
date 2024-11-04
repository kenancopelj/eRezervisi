import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/maintenance/maintenance_get_dto.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';

class MaintenanceItem extends StatefulWidget {
  final MaintenanceGetDto item;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  const MaintenanceItem(
      {super.key,
      required this.item,
      required this.isSelected,
      required this.onSelected});

  @override
  State<MaintenanceItem> createState() => _MaintenanceItemState();
}

class _MaintenanceItemState extends State<MaintenanceItem> {
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
                  width: 120, child: Text(widget.item.accommodationUnitTitle)),
              SizedBox(width: 120, child: Text(widget.item.status.toString())),
              SizedBox(
                  width: 120, child: Text(widget.item.priority.toString())),
            ],
          ),
        ),
      ),
    );
  }
}
