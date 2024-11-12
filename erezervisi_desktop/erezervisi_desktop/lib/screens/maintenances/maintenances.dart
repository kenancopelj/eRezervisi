import 'package:erezervisi_desktop/enums/maintenance_priority.dart';
import 'package:erezervisi_desktop/enums/maintenance_status.dart';
import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/dropdown_item.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_desktop/models/requests/maintenance/get_maintenances_request.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/maintenance/maintenance_get_dto.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/providers/maintenance_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/create_accommodation_unit.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/edit_accommodation_unit.dart';
import 'package:erezervisi_desktop/screens/maintenances/maintenance_item.dart';
import 'package:erezervisi_desktop/shared/components/form/dropdown.dart';
import 'package:erezervisi_desktop/shared/components/search_input.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/widgets/action_button.dart';
import 'package:erezervisi_desktop/widgets/confirmation_dialog.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/home_custom/accommodation_unit.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class MaintenancePriorityItem {
  late String label;
  late MaintenancePriority priority;
  late Color color;

  MaintenancePriorityItem(
      {required this.label, required this.priority, required this.color});
}

class MaintenanceStatusItem {
  late String label;
  late MaintenanceStatus status;
  late Color color;

  MaintenanceStatusItem(
      {required this.label, required this.status, required this.color});
}

class Maintenances extends StatefulWidget {
  const Maintenances({super.key});

  @override
  State<Maintenances> createState() => _AccommodationUnitsState();
}

class _AccommodationUnitsState extends State<Maintenances> {
  var maintenances = PagedResponse<MaintenanceGetDto>.empty();
  var request = GetMaintenancesRequest.def();

  List<MaintenancePriorityItem> priorities = [
    MaintenancePriorityItem(
        label: "Svi",
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
        priority: MaintenancePriority.Urgent,
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

  num? status;
  num? priority;

  late MaintenanceProvider maintenanceProvider;

  int currentPage = 1;
  final int pageSize = 6;

  List<num> selectedMaintenances = [];

  @override
  void initState() {
    super.initState();

    maintenanceProvider = context.read<MaintenanceProvider>();

    request.pageSize = pageSize;

    loadMaintenances();
  }

  Future loadMaintenances() async {
    var response = await maintenanceProvider.getPaged(request);

    if (mounted) {
      setState(() {
        selectedMaintenances = [];
        maintenances = response;
      });
    }
  }

  void handleSelectUnit(num unitId) {
    if (selectedMaintenances.any((x) => x == unitId) == false) {
      setState(() {
        selectedMaintenances.add(unitId);
      });
    } else {
      setState(() {
        selectedMaintenances.remove(unitId);
      });
    }
  }

  Future markAsCompleted(num maintenanceId) async {
    await maintenanceProvider.markAsCompleted(maintenanceId);

    loadMaintenances();
  }

  @override
  Widget build(BuildContext context) {
    List<MaintenanceGetDto> items = maintenances.items;

    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.cleaning_services_outlined,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Održavanja",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (selectedMaintenances.isNotEmpty &&
                          selectedMaintenances.length == 1 &&
                          maintenances.items
                                  .where((item) =>
                                      item.id == selectedMaintenances.first)
                                  .first
                                  .status !=
                              MaintenanceStatus.Completed)
                        ActionButton(
                            icon: Icons.check_outlined,
                            text: 'Označi kao završeno',
                            onClick: () {
                              if (selectedMaintenances.isEmpty) {
                                Globals.notifier.setInfo(
                                    "Odaberite jedno održavanje",
                                    ToastType.Info);
                                return;
                              }

                              if (selectedMaintenances.length > 1) {
                                return;
                              }

                              var selectedId = items
                                  .where(
                                      (x) => x.id == selectedMaintenances.first)
                                  .first
                                  .id;

                              markAsCompleted(selectedId);
                            }),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Dropdown(
                            outline: true,
                            padding: 10,
                            withSearch: false,
                            value: status,
                            placeholder: 'Status',
                            items: statuses
                                .map((item) => DropdownItem(
                                    key: item.status.index,
                                    value: "${item.label} "))
                                .toList(),
                            controller: TextEditingController(),
                            onChanged: (value) {
                              setState(() {
                                status = value != 0
                                    ? MaintenanceStatus.values
                                        .where((item) => item.index == value)
                                        .first
                                        .index
                                    : null;
                                if (status != null) {
                                  setState(() {
                                    request.status = MaintenanceStatus.values
                                        .where((item) => item.index == value)
                                        .first;
                                  });
                                } else {
                                  setState(() {
                                    request.status = null;
                                  });
                                }
                              });
                      
                              loadMaintenances();
                            }),
                      ),
                      SizedBox(
                        width: 300,
                        child: Dropdown(
                            outline: true,
                            padding: 10,
                            withSearch: false,
                            value: priority,
                            placeholder: 'Prioritet',
                            items: priorities
                                .map((item) => DropdownItem(
                                    key: item.priority.index,
                                    value: "${item.label} "))
                                .toList(),
                            controller: TextEditingController(),
                            onChanged: (value) {
                              setState(() {
                                priority = value != 0
                                    ? MaintenancePriority.values
                                        .where((item) => item.index == value)
                                        .first
                                        .index
                                    : null;
                      
                                if (priority != null) {
                                  setState(() {
                                    request.priority = MaintenancePriority.values
                                        .where((item) => item.index == value)
                                        .first;
                                  });
                                } else {
                                  setState(() {
                                    request.priority = null;
                                  });
                                }
                              });
                      
                              loadMaintenances();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 259,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Objekat",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Status",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Prioritet",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Expanded(
              child: items.isEmpty
                  ? const EmptyPage()
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var item = items[index];

                        return MaintenanceItem(
                            item: item,
                            isSelected: selectedMaintenances
                                .any((unit) => unit == item.id),
                            onSelected: (bool? value) =>
                                handleSelectUnit(item.id));
                      },
                    ),
            ),
            items.isEmpty
                ? const SizedBox.shrink()
                : Pagination(
                    currentPage: currentPage,
                    totalItems: maintenances.totalItems.toInt(),
                    itemsPerPage: pageSize,
                    onPageChanged: (newPage) {
                      setState(() {
                        currentPage = newPage;
                      });

                      maintenances.items = [];

                      loadMaintenances();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
