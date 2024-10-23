import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/reservation/get_reservations_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/providers/reservation_provider.dart';
import 'package:erezervisi_desktop/screens/reservations/reservation_details.dart';
import 'package:erezervisi_desktop/widgets/action_button.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:erezervisi_desktop/widgets/reservations/reservation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

enum ReservationsView { Calendar, List }

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  var reservations = PagedResponse<ReservationGetDto>.empty();
  var request = GetReservationsRequest.def();

  late ReservationProvider reservationProvider;

  int currentPage = 1;
  final int pageSize = 5;

  ReservationsView currentView = ReservationsView.Calendar;

  List<String> headers = ['Naziv', 'Cijena'];

  List<num> selectedReservations = [];

  bool selectAll = false;

  @override
  void initState() {
    super.initState();

    reservationProvider = context.read<ReservationProvider>();

    loadReservations();
  }

  Future loadReservations() async {
    request.pageSize = pageSize;
    request.page = currentPage;

    var response = await reservationProvider.getPaged(request);

    if (mounted) {
      setState(() {
        reservations = response;
      });
    }
  }

  void handleSelectReservation(num reservationId) {
    if (selectedReservations.any((x) => x == reservationId) == false) {
      setState(() {
        selectedReservations.add(reservationId);
      });
    } else {
      setState(() {
        selectedReservations.remove(reservationId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ReservationGetDto> items = reservations.items;

    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Rezervacije",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentView == ReservationsView.Calendar)
                    ActionButton(
                      icon: Icons.list_alt_outlined,
                      text: 'Lista',
                      onClick: () {
                        setState(() {
                          currentView = ReservationsView.List;
                        });
                      },
                    ),
                  if (currentView == ReservationsView.List)
                    ActionButton(
                      icon: Icons.calendar_month_outlined,
                      text: 'Kalendar',
                      onClick: () {
                        setState(() {
                          currentView = ReservationsView.Calendar;
                        });
                      },
                    ),
                  SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list_outlined,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Filtriraj",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (currentView == ReservationsView.List)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 66),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 20,
                      child: Checkbox(
                        value: selectAll,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sort,
                            color: CustomTheme.sortByColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Objekat",
                            style: CustomTheme.sortByTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sort,
                            color: CustomTheme.sortByColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Adresa",
                            style: CustomTheme.sortByTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sort,
                            color: CustomTheme.sortByColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Cijena",
                            style: CustomTheme.sortByTextStyle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            const Divider(
              thickness: 2,
            ),
            if (currentView == ReservationsView.List)
              Expanded(
                child: items.isEmpty
                    ? const EmptyPage()
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var item = items[index];

                          return ReservationItem(
                              item: item,
                              isSelected: selectedReservations
                                  .any((unit) => unit == item.id),
                              onSelected: (bool? value) =>
                                  handleSelectReservation(item.id));
                        },
                      ),
              ),
            if (currentView == ReservationsView.List)
              items.isEmpty
                  ? const SizedBox.shrink()
                  : Pagination(
                      currentPage: currentPage,
                      totalItems: reservations.totalItems.toInt(),
                      itemsPerPage: pageSize,
                      onPageChanged: (newPage) {
                        setState(() {
                          currentPage = newPage;
                        });

                        reservations.items = [];

                        loadReservations();
                      },
                    ),
            if (currentView == ReservationsView.Calendar)
              SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: SfCalendar(
                    view: CalendarView.month,
                    dataSource: ReservationDataSource(items),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                    onTap: (CalendarTapDetails details) {
                      if (details.appointments != null &&
                          details.appointments!.isNotEmpty) {
                        var reservation =
                            details.appointments!.first as ReservationGetDto;

                        _openReservationsDialog(context, reservation);
                      }
                    },
                  ))
          ],
        ),
      ),
    );
  }

  void _openReservationsDialog(
      BuildContext context, ReservationGetDto reservation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReservationDetails(
          reservation: reservation,
          onMessageSend: () => {print('poruka')},
        );
      },
    );
  }
}

class ReservationDataSource extends CalendarDataSource {
  ReservationDataSource(List<ReservationGetDto> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getReservationData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getReservationData(index).to;
  }

  @override
  String getSubject(int index) {
    var reservation = _getReservationData(index);
    return "${reservation.accommodationUnitTitle} - ${reservation.guest}";
  }

  ReservationGetDto _getReservationData(int index) {
    final dynamic reservation = appointments![index];
    late final ReservationGetDto reservationData;
    if (reservation is ReservationGetDto) {
      reservationData = reservation;
    }

    return reservationData;
  }
}
