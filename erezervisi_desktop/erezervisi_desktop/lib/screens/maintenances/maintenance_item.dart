import 'package:erezervisi_desktop/enums/maintenance_priority.dart';
import 'package:erezervisi_desktop/enums/maintenance_status.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/maintenance/maintenance_get_dto.dart';
import 'package:erezervisi_desktop/screens/maintenances/maintenances.dart';
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
  List<MaintenancePriorityItem> priorities = [
    MaintenancePriorityItem(
        label: "",
        priority: MaintenancePriority.Unknown,
        color: Colors.yellow),
    MaintenancePriorityItem(
        label: "Nizak",
        priority: MaintenancePriority.Low,
        color: Colors.yellow),
    MaintenancePriorityItem(
        label: "Srednji",
        priority: MaintenancePriority.Medium,
        color: Colors.orange),
    MaintenancePriorityItem(
        label: "Visok", priority: MaintenancePriority.High, color: Colors.red),
    MaintenancePriorityItem(
        label: "Hitno",
        priority: MaintenancePriority.Low,
        color: Colors.purple),
  ];

  List<MaintenanceStatusItem> statuses = [
    MaintenanceStatusItem(
        label: "Svi",
        status: MaintenanceStatus.Unknown,
        color: CustomTheme.bluePrimaryColor),
    MaintenanceStatusItem(
        label: "Kreirano",
        status: MaintenanceStatus.Created,
        color: CustomTheme.bluePrimaryColor),
    MaintenanceStatusItem(
        label: "Završeno",
        status: MaintenanceStatus.Completed,
        color: Colors.green),
  ];

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
                  width: 250, child: Text(widget.item.accommodationUnitTitle)),
              SizedBox(
                width: 200,
                child: Container(
                  width: 120,
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorities
                            .where((element) =>
                                element.priority == widget.item.priority)
                            .firstOrNull
                            ?.color ??
                        CustomTheme.bluePrimaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      priorities
                              .where((element) =>
                                  element.priority == widget.item.priority)
                              .firstOrNull
                              ?.label
                              .toUpperCase() ??
                          "N/A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Container(
                  width: 120,
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statuses
                            .where((element) =>
                                element.status == widget.item.status)
                            .firstOrNull
                            ?.color ??
                        CustomTheme.bluePrimaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      statuses
                              .where((element) =>
                                  element.status == widget.item.status)
                              .firstOrNull
                              ?.label
                              .toUpperCase() ??
                          "N/A",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
