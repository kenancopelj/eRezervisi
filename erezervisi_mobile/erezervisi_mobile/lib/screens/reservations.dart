import 'package:erezervisi_mobile/enums/reservation_status.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/dropdown_item.dart';
import 'package:erezervisi_mobile/models/requests/reservation/get_reservations_by_status_request.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_by_status_get_dto.dart';
import 'package:erezervisi_mobile/providers/reservation_provider.dart';
import 'package:erezervisi_mobile/shared/components/form/dropdown.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:erezervisi_mobile/widgets/reservations/reservation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationStatusItem {
  late String label;
  late ReservationStatus status;
  late Color color;

  ReservationStatusItem(
      {required this.label, required this.status, required this.color});
}

class MyReservations extends StatefulWidget {
  const MyReservations({super.key});

  @override
  State<MyReservations> createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  late ReservationProvider reservationProvider;

  var request = GetReservationsByStatusRequest.def();

  List<ReservationByStatusGetDto> reservations = [];

  num? status;

  List<ReservationStatusItem> statuses = [
    ReservationStatusItem(
        label: "Svi", status: ReservationStatus.Unknown, color: Colors.black),
    ReservationStatusItem(
        label: "Kreirano",
        status: ReservationStatus.Draft,
        color: CustomTheme.bluePrimaryColor),
    ReservationStatusItem(
        label: "Potvrđeno",
        status: ReservationStatus.Confirmed,
        color: Colors.green),
    ReservationStatusItem(
        label: "U toku",
        status: ReservationStatus.InProgress,
        color: Colors.orange),
    ReservationStatusItem(
        label: "Odbijeno",
        status: ReservationStatus.Declined,
        color: Colors.red),
    ReservationStatusItem(
        label: "Otkazano",
        status: ReservationStatus.Cancelled,
        color: Colors.brown),
    ReservationStatusItem(
        label: "Završeno",
        status: ReservationStatus.Completed,
        color: Colors.purple),
  ];

  @override
  void initState() {
    super.initState();

    reservationProvider = context.read<ReservationProvider>();

    loadReservations();
  }

  Future loadReservations() async {
    var response = await reservationProvider.getByStatus(request);
    if (mounted) {
      setState(() {
        reservations = response.reservations;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "Moje rezervacije",
                  style: CustomTheme.mediumTextStyle,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 300,
            child: Dropdown(
                outline: true,
                padding: 20,
                withSearch: false,
                value: status,
                placeholder: 'Status',
                items: statuses
                    .map((item) => DropdownItem(
                        key: item.status.index, value: "${item.label} "))
                    .toList(),
                controller: TextEditingController(),
                onChanged: (value) {
                  setState(() {
                    request.status = value != 0
                        ? ReservationStatus.values
                            .where((item) => item.index == value)
                            .first
                        : null;
                  });
                  loadReservations();
                }),
          ),
          SizedBox(
            height: 20,
          ),
          if (reservations.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                  children: reservations
                      .map((reservation) => ReservationItem(
                            reservation: reservation,
                            onStatusChanged: loadReservations,
                          ))
                      .toList()),
            ),
          if (reservations.isEmpty) Center(child: const Text("Nema podataka")),
          const SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }
}
