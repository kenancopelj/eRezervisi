// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:erezervisi_desktop/enums/accommodation_unit_filter.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/dashboard/get_dashboard_data_request.dart';
import 'package:erezervisi_desktop/models/responses/dashboard/dashboard_data_response.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/providers/dashboard_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/accommodation_units.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/create_accommodation_unit.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
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
  late DashboardProvider dashboardProvider;

  var request = GetDashboardDataRequest(month: 10, year: 2024);

  var dashboardData = DashboardDataResponse(
      availableAccommodationUnits: 0,
      expectedArrivals: 0,
      numberOfGuests: 0,
      numberOfReviews: 0,
      latestReservations: List.empty(),
      latestReviews: List.empty());

  @override
  void initState() {
    super.initState();
    dashboardProvider = context.read<DashboardProvider>();

    loadDashboardData();
  }

  Future loadDashboardData() async {
    var response = await dashboardProvider.get(request);

    if (mounted) {
      setState(() {
        dashboardData = response;
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
          Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardCard(
                    title: "Očekivani dolasci",
                    subtitle: "Broj zakazanih dolazaka za tekući mjesec",
                    icon: Icons.location_on_outlined,
                    value: dashboardData.expectedArrivals),
                DashboardCard(
                    title: "Dostupnih objekata",
                    subtitle: "Broj mojih dostupnih objekata",
                    icon: Icons.home_outlined,
                    value: dashboardData.availableAccommodationUnits),
                DashboardCard(
                    title: "Broj gostiju",
                    subtitle: "Ukupan broj gostiju u tekućem mjesecu",
                    icon: Icons.people_outline,
                    value: dashboardData.expectedArrivals),
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
                            value: dashboardData.numberOfGuests),
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
        const CreateAccommodationUnit(), true);
  }
}
