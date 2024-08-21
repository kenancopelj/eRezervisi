import 'package:erezervisi_mobile/enums/reservation_status.dart';
import 'package:erezervisi_mobile/models/requests/reservation/get_reservations_by_status_request.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_by_statuses_response.dart';
import 'package:erezervisi_mobile/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyReservations extends StatefulWidget {
  const MyReservations({super.key});

  @override
  State<MyReservations> createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations>
    with TickerProviderStateMixin {
  final TextStyle tabTextStyle = const TextStyle(fontSize: 12);

  late final TabController tabController;

  late ReservationProvider reservationProvider;

  var reservations = ReservationByStatusesResponse(reservations: []);

  var status = ReservationStatus.InProgress;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);

    reservationProvider = context.read<ReservationProvider>();

    loadReservations();
  }

  Future loadReservations() async {
    var response = await reservationProvider
        .getByStatus(GetReservationsByStatusRequest(status: status));

    if (mounted) {
      setState(() {
        reservations = response;
      });
    }
  }

  Color getColorByStatus() {
    switch (status) {
      case ReservationStatus.InProgress:
        return Colors.amber[400]!;
      case ReservationStatus.Confirmed:
        return Colors.green[600]!;
      case ReservationStatus.Draft:
        return Colors.orangeAccent[600]!;
      case ReservationStatus.Completed:
        return Colors.blueAccent;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Moje rezervacije",
              style: TextStyle(fontSize: 20),
            ),
            bottom: TabBar(
                indicatorColor: getColorByStatus(),
                onTap: (value) {
                  setState(() {
                    status = ReservationStatus.values
                        .where((x) => x.index == value + 1)
                        .first;

                    reservations =
                        ReservationByStatusesResponse(reservations: []);
                    loadReservations();
                  });
                },
                controller: tabController,
                tabs: [
                  Tab(
                    key: Key(ReservationStatus.InProgress.toString()),
                    icon: Text("U toku", style: tabTextStyle),
                  ),
                  Tab(
                    key: Key(ReservationStatus.Confirmed.toString()),
                    icon: Text(
                      "Potvrđene",
                      style: tabTextStyle,
                    ),
                  ),
                  Tab(
                    key: Key(ReservationStatus.Draft.toString()),
                    icon: Text(
                      "Nepotvrđene",
                      style: tabTextStyle,
                    ),
                  ),
                  Tab(
                    key: Key(ReservationStatus.Completed.toString()),
                    icon: Text(
                      "Završene",
                      style: tabTextStyle,
                    ),
                  ),
                ]),
          ),
          body: reservations.reservations.isEmpty
              ? const Center(
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      children: [
                        Icon(
                          Icons.folder_outlined,
                          size: 32,
                        ),
                        Text("Nema podataka"),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: reservations.reservations
                      .map(
                        (reservation) => Container(
                          height: 70,
                          color: getColorByStatus(),
                          child: Center(
                            child: Text(reservation.code),
                          ),
                        ),
                      )
                      .toList()),
        ));
  }
}
