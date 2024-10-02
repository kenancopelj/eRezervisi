// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:erezervisi_mobile/enums/accommodation_unit_filter.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_mobile/models/requests/category/get_all_categories_request.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/category/categories.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/category_provider.dart';
import 'package:erezervisi_mobile/screens/accommodation_units.dart';
import 'package:erezervisi_mobile/screens/create_accommodation_unit.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/widgets/home_custom/category_card_list.dart';
import 'package:erezervisi_mobile/widgets/home_custom/item_card_list.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var categories = Categories(categories: []);
  var accommodationUnits = PagedResponse<AccommodationUnitGetDto>.empty();
  var latestAccommodationUnits = PagedResponse<AccommodationUnitGetDto>.empty();
  var popularAccommodationUnits =
      PagedResponse<AccommodationUnitGetDto>.empty();

  late CategoryProvider categoryProvider;
  late AccommodationUnitProvider accommodationUnitProvider;

  var request = GetAccommodationUnitsRequest.def();
  var latestRequest = GetAccommodationUnitsRequest.def();
  var popularRequest = GetAccommodationUnitsRequest.def();

  @override
  void initState() {
    super.initState();
    categoryProvider = context.read<CategoryProvider>();
    accommodationUnitProvider = context.read<AccommodationUnitProvider>();

    loadCategories();
    loadAccommodationUnits();
    loadLatestAccommodationUnits();
    loadPopularAccommodationUnits();
  }

  Future loadCategories() async {
    var response = await categoryProvider.getAll(GetAllCategoriesRequest(
        searchTerm: Globals.baseGetAllRequest.searchTerm));

    if (mounted) {
      setState(() {
        categories = response;
      });
    }
  }

  Future loadAccommodationUnits() async {
    var response = await accommodationUnitProvider.getPaged(request);

    if (mounted) {
      setState(() {
        accommodationUnits = response;
      });
    }
  }

  Future loadLatestAccommodationUnits() async {
    latestRequest.pageSize = 5;

    var response =
        await accommodationUnitProvider.getLatestPaged(latestRequest);

    if (mounted) {
      setState(() {
        latestAccommodationUnits = response;
      });
    }
  }

  Future loadPopularAccommodationUnits() async {
    popularRequest.pageSize = 5;

    var response =
        await accommodationUnitProvider.getPopularPaged(popularRequest);

    if (mounted) {
      setState(() {
        popularAccommodationUnits = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: showNewAccommodationUnitScreen,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Style.primaryColor100,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pretraži',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CategoryCardList(
                    categories: categories,
                    onClick: (num value) {
                      setState(() {
                        request.categoryId = value;
                        accommodationUnits =
                            PagedResponse<AccommodationUnitGetDto>.empty();
                      });
                      loadAccommodationUnits();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Preporučeno',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          navigateToList(AccommodationUnitFilter.Recommended);
                        },
                        child: Text(
                          "Pogledaj sve",
                          style: TextStyle(
                              color: CustomTheme.bluePrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemCardList(
                    items: accommodationUnits.items,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nove ponude',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          navigateToList(AccommodationUnitFilter.Latest);
                        },
                        child: Text(
                          "Pogledaj sve",
                          style: TextStyle(
                              color: CustomTheme.bluePrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemCardList(
                    items: latestAccommodationUnits.items,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Popularno',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          navigateToList(AccommodationUnitFilter.Popular);
                        },
                        child: Text(
                          "Pogledaj sve",
                          style: TextStyle(
                              color: CustomTheme.bluePrimaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemCardList(
                    items: popularAccommodationUnits.items,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  navigateToList(AccommodationUnitFilter filter) {
    Navigate.next(context, AppRoutes.accommodationUnits.routeName,
        AccommodationUnits(filter: filter), true);
  }

  showNewAccommodationUnitScreen() {
    Navigate.next(context, AppRoutes.createAccommodationUnit.routeName,
        const CreateAccommodationUnitScreen(), true);
  }
}
