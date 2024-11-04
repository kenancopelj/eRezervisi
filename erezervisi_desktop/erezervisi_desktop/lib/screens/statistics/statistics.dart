import 'package:erezervisi_desktop/models/dropdown_item.dart';
import 'package:erezervisi_desktop/models/requests/statistics/get_guests_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/requests/statistics/get_reservations_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_guests_by_year_dto.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_reservations_by_year_dto.dart';
import 'package:erezervisi_desktop/providers/statistics_provider.dart';
import 'package:erezervisi_desktop/shared/components/form/dropdown.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  var reservationsMonthly = List<GetReservationsByYearDto>.empty();
  var guestsMonthly = List<GetGuestsByYearDto>.empty();

  var reservationsRequest = GetReservationsYearOrMonthRequest.def();
  var guestsRequest = GetGuestsYearOrMonthRequest.def();

  late StatisticsProvider statisticsProvider;

  var currentYear = DateTime.now().year;
  var currentMonth = DateTime.now().month;

  List<int> years = [];
  List<int?> months = [null];

  @override
  void initState() {
    super.initState();

    statisticsProvider = context.read<StatisticsProvider>();

    getLastFiveYears();
    getMonths();
    loadReservationsMonthly();
    loadGuestsMonthly();
  }

  getMonths() {
    for (var i = currentMonth; i >= 1; i--) {
      months.add(i);
    }
  }

  getLastFiveYears() {
    setState(() {
      reservationsRequest.year = currentYear;
      guestsRequest.year = currentYear;
    });

    for (var i = 0; i < 5; i++) {
      years.add(currentYear - i);
    }
  }

  Future loadReservationsMonthly() async {
    var response =
        await statisticsProvider.getReservationsByYear(reservationsRequest);

    if (mounted) {
      setState(() {
        reservationsMonthly = response;
      });
    }
  }

  Future loadGuestsMonthly() async {
    var response = await statisticsProvider.getGuestsByYear(guestsRequest);

    if (mounted) {
      setState(() {
        guestsMonthly = response;
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
                const Icon(
                  Icons.bar_chart_outlined,
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Statistika",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ),
                const Spacer(),
                SizedBox(
                  width: 300,
                  child: Dropdown(
                      withSearch: false,
                      value: reservationsRequest.month,
                      placeholder: 'Mjesec',
                      items: months
                          .map((item) => DropdownItem(
                              key: item ?? -1, value: "${item ?? 'Svi'} "))
                          .toList(),
                      controller: TextEditingController(),
                      onChanged: (value) => {
                            setState(() {
                              reservationsRequest.month =
                                  value == -1 ? null : value;
                              guestsRequest.month = value == -1 ? null : value;
                              loadReservationsMonthly();
                            })
                          }),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 300,
                  child: Dropdown(
                      withSearch: false,
                      value: reservationsRequest.year,
                      placeholder: 'Godina',
                      items: years
                          .map(
                              (item) => DropdownItem(key: item, value: "$item"))
                          .toList(),
                      controller: TextEditingController(),
                      onChanged: (value) => {
                            setState(() {
                              reservationsRequest.year = value;
                              guestsRequest.year = value;
                              loadReservationsMonthly();
                            })
                          }),
                )
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: SfCartesianChart(
                title:
                    const ChartTitle(text: "Broj rezervacija u tekućoj godini"),
                primaryXAxis: const CategoryAxis(),
                series: <LineSeries<GetReservationsByYearDto, num>>[
                  LineSeries<GetReservationsByYearDto, num>(
                      dataSource: reservationsMonthly,
                      xValueMapper: (GetReservationsByYearDto item, _) =>
                          item.month,
                      yValueMapper: (GetReservationsByYearDto item, _) =>
                          item.totalReservations)
                ]),
          ),
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 400,
            child: SfCartesianChart(
                title: const ChartTitle(text: "Broj gostiju u tekućoj godini"),
                primaryXAxis: const CategoryAxis(),
                series: <LineSeries<GetGuestsByYearDto, num>>[
                  LineSeries<GetGuestsByYearDto, num>(
                      dataSource: guestsMonthly,
                      xValueMapper: (GetGuestsByYearDto item, _) => item.month,
                      yValueMapper: (GetGuestsByYearDto item, _) =>
                          item.totalGuests)
                ]),
          ),
        ],
      ),
    ));
  }
}
