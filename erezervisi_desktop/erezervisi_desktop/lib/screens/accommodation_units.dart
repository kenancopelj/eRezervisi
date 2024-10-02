import 'package:erezervisi_desktop/enums/accommodation_unit_filter.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/widgets/action_button.dart';
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

  List<String> headers = ['Naziv', 'Cijena'];

  Map<num, bool> selectedUnits = {};

  bool selectAll = false;

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
        accommodationUnits = response;
      });
    }
  }

  void handleSelectUnit(num unitId, bool? value) {
    setState(() {
      selectedUnits[unitId] = value ?? false;
    });
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
            const Divider(),
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
                          print('Save button clicked!');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                        icon: Icons.edit,
                        text: 'Uredi',
                        onClick: () {
                          print('Save button clicked!');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                        icon: Icons.delete,
                        text: 'Ukloni',
                        onClick: () {
                          print('Save button clicked!');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list_outlined,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Filtriraj",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
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
            const Divider(),
            Expanded(
              child: items.isEmpty
                  ? const EmptyPage()
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var item = items[index];

                        return AccommodationUnit(
                            item: item,
                            isSelected: selectedUnits[item.id] ?? false,
                            onSelected: (bool? value) =>
                                handleSelectUnit(item.id, value));
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
