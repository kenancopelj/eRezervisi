// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:erezervisi_desktop/enums/accommodation_unit_filter.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_desktop/models/requests/category/get_all_categories_request.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/category/categories.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/providers/category_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units.dart';
import 'package:erezervisi_desktop/screens/create_accommodation_unit.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/shared/style.dart';
import 'package:erezervisi_desktop/widgets/home_custom/dashboard_card.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/reviews_custom/review_item.dart';
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
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.home_outlined),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Dobrodošli, ${Globals.loggedUser!.firstName} ${Globals.loggedUser!.lastName}",
                  style: CustomTheme.mediumTextStyle,
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardCard(
                    title: "Očekivani dolasci",
                    subtitle: "Broj zakazanih dolazaka za tekući mjesec",
                    icon: Icons.location_on_outlined,
                    value: 2),
                DashboardCard(
                    title: "Dostupnih objekata",
                    subtitle: "Broj mojih dostupnih objekata",
                    icon: Icons.home_outlined,
                    value: 3),
                DashboardCard(
                    title: "Broj gostiju",
                    subtitle: "Ukupan broj gostiju u tekućem mjesecu",
                    icon: Icons.people_outline,
                    value: 8),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30, left: 50),
                child: Row(
                  children: [
                    Column(
                      children: [
                        DashboardCard(
                            title: "Broj recenzija",
                            subtitle: "Broj recenzija za aktivne objekte",
                            icon: Icons.favorite_outline,
                            value: 10),
                        SizedBox(
                          height: 30,
                        ),
                        DashboardCard(
                          title: "Posljednje recenzije",
                          subtitle: "Pregled posljednjih recenzija",
                          icon: Icons.favorite_outline,
                          content: ReviewItem(
                            item: ReviewGetDto(
                                id: 1,
                                title: "Dobar",
                                note: "Jako uredno i čisto, sve preporuke",
                                rating: 5,
                                reviewerId: 1,
                                reviewer: "Kenan Čopelj"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: DashboardCard(
                  width: 1060,
                  title: "Posljednje rezervacije",
                  subtitle: "Pregled posljednjih rezervacija",
                  icon: Icons.favorite_outline,
                  content: ReviewItem(
                    item: ReviewGetDto(
                        id: 1,
                        title: "Dobar",
                        note: "Jako uredno i čisto, sve preporuke",
                        rating: 5,
                        reviewerId: 1,
                        reviewer: "Kenan Čopelj"),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  navigateToList(AccommodationUnitFilter filter) {
    Navigate.next(context, AppRoutes.accommodationUnits.routeName,
        AccommodationUnits(), true);
  }

  showNewAccommodationUnitScreen() {
    Navigate.next(context, AppRoutes.createAccommodationUnit.routeName,
        const CreateAccommodationUnitScreen(), true);
  }
}
