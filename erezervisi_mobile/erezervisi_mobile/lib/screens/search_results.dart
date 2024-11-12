import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/screens/filter_results.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/pagination.dart';
import 'package:erezervisi_mobile/widgets/home_custom/small_item_card.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchResults extends StatefulWidget {
  final String searchTerm;
  num? categoryId;
  String? categoryTitle;
  num? townshipId;
  String? townshipTitle;
  num? cantonId;
  String? cantonTitle;
  bool? oneNightOnly;
  bool? alcoholAllowed;
  num? capacity;
  bool? withPool;
  bool? birthdayPartiesAllowed;

  SearchResults(
      {required this.searchTerm,
      this.categoryId,
      this.categoryTitle,
      this.townshipId,
      this.townshipTitle,
      this.cantonId,
      this.cantonTitle,
      this.oneNightOnly,
      this.alcoholAllowed,
      this.capacity,
      this.withPool,
      this.birthdayPartiesAllowed,
      super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late AccommodationUnitProvider accommodationUnitProvider;

  int currentPage = 1;

  var pagedResponse = PagedResponse<AccommodationUnitGetDto>.empty();

  var request = GetAccommodationUnitsRequest.def();

  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    accommodationUnitProvider = context.read<AccommodationUnitProvider>();

    request.searchTerm = widget.searchTerm;
    request.categoryId = widget.categoryId;
    request.townshipId = widget.townshipId;
    request.cantonId = widget.cantonId;
    request.oneNightOnly = widget.oneNightOnly;
    request.alcoholAllowed = widget.alcoholAllowed;
    request.capacity = widget.capacity;
    request.withPool = widget.withPool;
    request.birthdayPartiesAllowed = widget.birthdayPartiesAllowed;

    loadAccommodationUnits();
  }

  Future loadAccommodationUnits() async {
    request.page = currentPage;
    request.pageSize = 5;
    var response = await accommodationUnitProvider.getPaged(request);

    setState(() {
      pagedResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rezultati za '${widget.searchTerm}'",
                style: CustomTheme.mediumTextStyle,
              ),
              IconButton(
                icon: const Icon(Icons.filter_list_outlined),
                onPressed: () {
                  Navigate.next(
                      context,
                      AppRoutes.filterResults.routeName,
                      FilterResults(
                        searchTerm: widget.searchTerm,
                        capacity: request.capacity,
                        categoryId: request.categoryId,
                        cantonId: request.cantonId,
                        townshipId: request.townshipId,
                        oneNightOnly: request.oneNightOnly,
                        alcoholAllowed: request.alcoholAllowed,
                        withPool: request.withPool,
                        birthdayPartiesAllowed: request.birthdayPartiesAllowed,
                      ),
                      true);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (widget.categoryId != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              widget.categoryTitle ?? "",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.categoryId = null;
                                    widget.categoryId = null;
                                    widget.categoryTitle = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.cantonId != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              widget.cantonTitle ?? "",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.cantonId = null;
                                    widget.cantonId = null;
                                    widget.cantonTitle = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.townshipId != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              widget.townshipTitle ?? "",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.townshipId = null;
                                    widget.townshipId = null;
                                    widget.townshipTitle = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.alcoholAllowed != null &&
                    widget.alcoholAllowed == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Alkohol dozvoljen",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.alcoholAllowed = null;
                                    widget.alcoholAllowed = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.birthdayPartiesAllowed != null &&
                    widget.birthdayPartiesAllowed == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Rođendanske proslave",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.birthdayPartiesAllowed = null;
                                    widget.birthdayPartiesAllowed = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.oneNightOnly != null && widget.oneNightOnly == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Jedno noćenje",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.oneNightOnly = null;
                                    widget.oneNightOnly = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.withPool != null && widget.withPool == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Bazen",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.withPool = null;
                                    widget.withPool = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.capacity != null && widget.capacity! > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 196, 196, 196),
                          borderRadius: BorderRadius.circular(10)),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          children: [
                            Text(
                              "Kapacitet: ${widget.capacity!}",
                              style: CustomTheme.smallTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    request.capacity = null;
                                    widget.capacity = null;
                                  });

                                  loadAccommodationUnits();
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
        Expanded(
          child: pagedResponse.items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_outlined,
                        size: 56,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Nema podataka',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Trenutno nema podataka po zadanim parametrima.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: pagedResponse.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SmallItemCard(
                      item: pagedResponse.items[index],
                    );
                  },
                ),
        ),
        if (pagedResponse.totalPages > 1)
          Pagination(
            currentPage: currentPage,
            totalItems: pagedResponse.totalItems.toInt(),
            itemsPerPage: pagedResponse.pageSize.toInt(),
            onPageChanged: (newPage) {
              setState(() {
                currentPage = newPage;
              });

              pagedResponse.items = [];

              loadAccommodationUnits();
            },
          )
      ],
    ));
  }
}
