import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
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

class Maintenances extends StatefulWidget {
  const Maintenances({super.key});

  @override
  State<Maintenances> createState() => _AccommodationUnitsState();
}

class _AccommodationUnitsState extends State<Maintenances> {
  var maintenances = PagedResponse<MaintenanceGetDto>.empty();
  var request = GetMaintenancesRequest.def();

  late MaintenanceProvider maintenanceProvider;

  int currentPage = 1;
  final int pageSize = 5;

  List<num> selectedMaintenances = [];

  bool selectAll = false;

  @override
  void initState() {
    super.initState();

    maintenanceProvider = context.read<MaintenanceProvider>();

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
                      ActionButton(
                          icon: Icons.delete,
                          text: 'Označi kao završeno',
                          onClick: () {
                            if (selectedMaintenances.isEmpty) {
                              Globals.notifier.setInfo(
                                  "Odaberite jedno održavanje", ToastType.Info);
                              return;
                            }

                            if (selectedMaintenances.length > 1) {
                              return;
                            }

                            var selectedUnitId = items
                                .where(
                                    (x) => x.id == selectedMaintenances.first)
                                .first
                                .id;

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return ConfirmationDialog(
                            //         title: 'Obriši objekte',
                            //         content:
                            //             'Da li ste sigurni da želite obrisati odabrane objekte?',
                            //         onConfirm: () {
                            //           deleteAccommodationUnit(selectedUnitId);
                            //         });
                            //   },
                            // );
                          }),
                    ],
                  ),
                  SearchInput(onChanged: (value) {
                    setState(() {
                      request.searchTerm = value;
                    });

                    loadMaintenances();
                  })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                    child: Checkbox(
                      value: selectAll,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  SizedBox(
                    width: 120,
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
                    width: 120,
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
                    width: 120,
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
