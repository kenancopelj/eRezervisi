import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/screens/accommodation_unit_details.dart';
import 'package:erezervisi_mobile/screens/search_results.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Debouncer _debouncer = Debouncer();

  var searchController = TextEditingController();

  bool searchInProgress = false;

  var request = GetAccommodationUnitsRequest.def();

  var accommodationUnits = PagedResponse<AccommodationUnitGetDto>.empty();

  late AccommodationUnitProvider accommodationUnitProvider;

  @override
  void initState() {
    super.initState();

    accommodationUnitProvider = context.read<AccommodationUnitProvider>();
  }

  Future loadAccommodationUnits() async {
    var response = await accommodationUnitProvider.getPaged(request);

    setState(() {
      accommodationUnits = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: accommodationUnits.items.isEmpty
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () {
                  Navigate.next(context, AppRoutes.searchResults.routeName,
                      SearchResults(searchTerm: request.searchTerm));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '${accommodationUnits.totalItems} rezultata',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: ListView(
            children: [
              TextField(
                style: const TextStyle(fontSize: 14),
                controller: searchController,
                onChanged: (value) {
                  if (value.length >= 3) {
                    _debouncer.debounce(
                        duration: Globals.debounceTimeout,
                        onDebounce: () {
                          setState(() {
                            request.searchTerm = value.trim();
                          });

                          loadAccommodationUnits();
                        });
                  } else if (accommodationUnits.items.isNotEmpty) {
                    setState(() {
                      accommodationUnits =
                          PagedResponse<AccommodationUnitGetDto>.empty();
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Unesite minimalno 3 karaktera za pretragu',
                  hintStyle: CustomTheme.smallTextStyle,
                  suffixIcon: const Icon(Icons.search_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: accommodationUnits.items.length,
                itemBuilder: (context, index) {
                  var accommodationUnit = accommodationUnits.items[index];

                  return InkWell(
                    onTap: () {
                      Navigate.next(
                          context,
                          AppRoutes.accommodationUnitDetails.routeName,
                          ObjectDetails(
                              accommodationUnitId: accommodationUnit.id),
                          true);
                    },
                    child: ListTile(
                      leading: const Icon(Icons.search),
                      title: Text(accommodationUnit.title),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
