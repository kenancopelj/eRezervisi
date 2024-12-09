import 'dart:io';

import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/helpers/helpers.dart';
import 'package:erezervisi_desktop/models/dropdown_item.dart';
import 'package:erezervisi_desktop/models/requests/statistics/get_guests_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/requests/statistics/get_reservations_year_or_month_request.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_guests_by_year_dto.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_reservations_by_year_dto.dart';
import 'package:erezervisi_desktop/models/responses/statistics/get_revenue_dto.dart';
import 'package:erezervisi_desktop/providers/statistics_provider.dart';
import 'package:erezervisi_desktop/shared/components/form/dropdown.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pdf/widgets.dart' as pw;

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

  var revenue = GetRevenueDto(
      averageReservationPrice: 0,
      totalNumberOfReservations: 0,
      totalRevenue: 0,
      revenueThisMonth: 0,
      revenueLastMonth: 0);

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
    getRevenue();
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

  Future getRevenue() async {
    var response = await statisticsProvider.getRevenue();

    if (mounted) {
      setState(() {
        revenue = response;
      });
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
                IconButton(
                    onPressed: () async {
                      List<List<String>> tableData = [];

                      tableData.add(["Mjesec", "Broj rezervacija"]);

                      for (var i = 1; i <= 12; i++) {
                        var item = reservationsMonthly
                            .where((item) => item.month == i)
                            .firstOrNull;
                        tableData.add([
                          Helpers.getMonthName(i),
                          "${item?.totalReservations ?? 0}"
                        ]);
                      }

                      await generatePdf(tableData);
                    },
                    icon: const Icon(Icons.download))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildStatCard('Ukupno rezervacija',
                          "${revenue.totalNumberOfReservations}", Icons.home),
                      buildStatCard(
                          'Prosječna cijena',
                          "${revenue.averageReservationPrice.toStringAsFixed(2)} KM",
                          Icons.line_axis_sharp),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildProfitCard(),
                ],
              ),
            ),
          ),
          Row(
            children: [
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
                    onChanged: (value) {
                      setState(() {
                        reservationsRequest.month = value == -1 ? null : value;
                        guestsRequest.month = value == -1 ? null : value;
                      });

                      loadReservationsMonthly();
                      loadGuestsMonthly();
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
                        .map((item) => DropdownItem(key: item, value: "$item"))
                        .toList(),
                    controller: TextEditingController(),
                    onChanged: (value) {
                      setState(() {
                        reservationsRequest.year = value;
                        guestsRequest.year = value;
                      });
                      loadReservationsMonthly();
                      loadGuestsMonthly();
                    }),
              )
            ],
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

  Widget buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(icon, color: CustomTheme.bluePrimaryColor, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfitCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dobit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildProfitColumn(
                    "${revenue.revenueThisMonth.toStringAsFixed(2)} KM",
                    'Ovaj mjesec'),
                buildProfitColumn(
                    "${revenue.revenueLastMonth.toStringAsFixed(2)} KM",
                    'Prethodni mjesec'),
                buildProfitColumn(
                    "${revenue.totalRevenue.toStringAsFixed(2)} KM",
                    'Ukupna dobit'),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildProfitColumn(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Future<void> generatePdf(List<List<String>> tableData) async {
    final pdf = pw.Document();

    // Add a table to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Text(
              "Statistika",
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
                "Datum izvjestaja: ${DateFormat("dd.MM.yyy HH:mm").format(DateTime.now())}",
                style: const pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              context: context,
              data: tableData,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.center,
              cellHeight: 40,
            ),
            pw.SizedBox(height: 20),
            pw.Row(children: [
              pw.Text(
                  "Ukupno rezervacija do danasnjeg dana: ${revenue.totalNumberOfReservations}"),
              pw.Spacer(),
              pw.Text(
                  "Prosjecna cijena rezervacije: ${revenue.averageReservationPrice.toStringAsFixed(2)} KM"),
              pw.SizedBox(height: 20),
            ]),
            pw.Row(children: [
              pw.Text(
                  "Dobit - ovaj mjesec: ${revenue.revenueThisMonth.toStringAsFixed(2)} KM"),
              pw.Spacer(),
              pw.Text(
                  "Dobit - prethodni mjesec: ${revenue.revenueLastMonth.toStringAsFixed(2)} KM"),
            ]),
            pw.SizedBox(height: 10),
            pw.Text(
                "Sveukupna dobit do dananjeg dana: ${revenue.totalRevenue.toStringAsFixed(2)} KM"),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        "${directory.path}/statistika_${DateFormat("yyyy-MM-dd_hh_mm").format(DateTime.now())}.pdf");
    await file.writeAsBytes(await pdf.save());

    Globals.notifier.setInfo(
        "Fajl uspješno preuzet na lokaciju ${file.path}", ToastType.Success);
  }
}
