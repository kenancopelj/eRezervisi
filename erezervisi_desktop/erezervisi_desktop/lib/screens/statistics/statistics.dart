import 'package:erezervisi_desktop/models/requests/statistics/get_guests_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/requests/statistics/get_reservations_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_guests_by_year_dto.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_reservations_by_year_dto.dart';
import 'package:erezervisi_desktop/providers/statistics_provider.dart';
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

  @override
  void initState() {
    super.initState();

    statisticsProvider = context.read<StatisticsProvider>();

    loadReservationsMonthly();
    loadGuestsMonthly();
  }

  Future loadReservationsMonthly() async {
    reservationsRequest.year = 2024;

    var response =
        await statisticsProvider.getReservationsByYear(reservationsRequest);

    if (mounted) {
      setState(() {
        reservationsMonthly = response;
      });
    }
  }

  Future loadGuestsMonthly() async {
    guestsRequest.year = 2024;

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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart_outlined,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Statistika",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ),
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
