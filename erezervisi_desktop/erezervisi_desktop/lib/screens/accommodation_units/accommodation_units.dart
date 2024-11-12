import 'package:erezervisi_desktop/enums/accommodation_unit_status.dart';
import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/create_accommodation_unit.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/edit_accommodation_unit.dart';
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

class AccommodationUnits extends StatefulWidget {
  const AccommodationUnits({super.key});

  @override
  State<AccommodationUnits> createState() => _AccommodationUnitsState();
}

class _AccommodationUnitsState extends State<AccommodationUnits> {
  var accommodationUnits = PagedResponse<AccommodationUnitGetDto>.empty();
  var request = GetAccommodationUnitsRequest.def();

  late AccommodationUnitProvider accommodationUnitProvider;

  int currentPage = 1;
  final int pageSize = 5;

  List<num> selectedUnits = [];

  @override
  void initState() {
    super.initState();

    accommodationUnitProvider = context.read<AccommodationUnitProvider>();

    loadAccommodationUnits();
  }

  Future loadAccommodationUnits() async {
    request.ownerId = Globals.loggedUser!.userId;
    request.pageSize = pageSize;
    request.page = currentPage;
    var response = await accommodationUnitProvider.getPaged(request);

    if (mounted) {
      setState(() {
        selectedUnits = [];
        accommodationUnits = response;
      });
    }
  }

  Future deleteAccommodationUnit(num id) async {
    await accommodationUnitProvider.delete(id);
    loadAccommodationUnits();
  }

  Future activateAccommodationUnit(num id) async {
    await accommodationUnitProvider.activate(id);
    loadAccommodationUnits();
  }

  Future deactivateAccommodationUnit(num id) async {
    await accommodationUnitProvider.deactivate(id);
    loadAccommodationUnits();
  }

  void handleSelectUnit(num unitId) {
    if (selectedUnits.any((x) => x == unitId) == false) {
      setState(() {
        selectedUnits.add(unitId);
      });
    } else {
      setState(() {
        selectedUnits.remove(unitId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<AccommodationUnitGetDto> items = accommodationUnits.items;

    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Objekti",
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
                        icon: Icons.add,
                        text: 'Novo',
                        onClick: () {
                          Navigate.next(
                              context,
                              AppRoutes.createAccommodationUnit.routeName,
                              const CreateAccommodationUnit(),
                              true);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                        icon: Icons.edit,
                        text: 'Uredi',
                        onClick: () {
                          if (selectedUnits.isEmpty) {
                            Globals.notifier.setInfo(
                                "Odaberite jedan objekt", ToastType.Info);
                            return;
                          }

                          if (selectedUnits.length > 1) {
                            return;
                          }

                          var selectedUnit = items
                              .where((x) => x.id == selectedUnits.first)
                              .first;

                          Navigate.next(
                              context,
                              AppRoutes.editAccommodationUnit.routeName,
                              EditAccommodationUnit(
                                accommodationUnitId: selectedUnit.id,
                              ),
                              true);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (selectedUnits.isNotEmpty &&
                          selectedUnits.length == 1 &&
                          items
                                  .where((x) => x.id == selectedUnits.first)
                                  .first
                                  .status ==
                              AccommodationUnitStatus.Active)
                        ActionButton(
                            icon: Icons.remove,
                            text: 'Deaktiviraj',
                            onClick: () {
                              if (selectedUnits.isEmpty) {
                                Globals.notifier.setInfo(
                                    "Odaberite jedan objekt", ToastType.Info);
                                return;
                              }

                              if (selectedUnits.length > 1) {
                                return;
                              }

                              var selectedUnitId = items
                                  .where((x) => x.id == selectedUnits.first)
                                  .first
                                  .id;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmationDialog(
                                      title: 'Deaktiviraj objekat',
                                      content:
                                          'Da li ste sigurni da želite deaktivirati odabrani objekat?',
                                      onConfirm: () {
                                        deactivateAccommodationUnit(
                                            selectedUnitId);
                                      });
                                },
                              );
                            }),
                      if (selectedUnits.isNotEmpty &&
                          selectedUnits.length == 1 &&
                          items
                                  .where((x) => x.id == selectedUnits.first)
                                  .first
                                  .status !=
                              AccommodationUnitStatus.Active)
                        ActionButton(
                            icon: Icons.check,
                            text: 'Aktiviraj',
                            onClick: () {
                              if (selectedUnits.isEmpty) {
                                Globals.notifier.setInfo(
                                    "Odaberite jedan objekt", ToastType.Info);
                                return;
                              }

                              if (selectedUnits.length > 1) {
                                return;
                              }

                              var selectedUnitId = items
                                  .where((x) => x.id == selectedUnits.first)
                                  .first
                                  .id;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmationDialog(
                                      title: 'Aktiviraj objekat',
                                      content:
                                          'Da li ste sigurni da želite aktivirati odabrani objekat?',
                                      onConfirm: () {
                                        activateAccommodationUnit(
                                            selectedUnitId);
                                      });
                                },
                              );
                            }),
                      const SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          icon: Icons.delete,
                          text: 'Ukloni',
                          onClick: () {
                            if (selectedUnits.isEmpty) {
                              Globals.notifier.setInfo(
                                  "Odaberite jedan objekt", ToastType.Info);
                              return;
                            }

                            if (selectedUnits.length > 1) {
                              return;
                            }

                            var selectedUnitId = items
                                .where((x) => x.id == selectedUnits.first)
                                .first
                                .id;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmationDialog(
                                    title: 'Obriši objekte',
                                    content:
                                        'Da li ste sigurni da želite obrisati odabrane objekte?',
                                    onConfirm: () {
                                      deleteAccommodationUnit(selectedUnitId);
                                    });
                              },
                            );
                          }),
                    ],
                  ),
                  SearchInput(onChanged: (value) {
                    setState(() {
                      currentPage = 1;
                      request.searchTerm = value;
                    });

                    loadAccommodationUnits();
                  })
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
                          "Adresa",
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
                          "Cijena",
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

                        return AccommodationUnit(
                            item: item,
                            isSelected:
                                selectedUnits.any((unit) => unit == item.id),
                            onSelected: (bool? value) =>
                                handleSelectUnit(item.id));
                      },
                    ),
            ),
            items.isEmpty
                ? const SizedBox.shrink()
                : Pagination(
                    currentPage: currentPage,
                    totalItems: accommodationUnits.totalItems.toInt(),
                    itemsPerPage: pageSize,
                    onPageChanged: (newPage) {
                      setState(() {
                        currentPage = newPage;
                      });

                      accommodationUnits.items = [];

                      loadAccommodationUnits();
                    },
                  )
          ],
        ),
      ),
    );
  }
}

//  SizedBox(
//               height: 60,
//               width: 60,
//               child: image != null
//                   ? Image.file(File(image!.path), fit: BoxFit.cover)
//                   : const Icon(Icons.image, size: 60, color: Colors.grey),
//             ),
