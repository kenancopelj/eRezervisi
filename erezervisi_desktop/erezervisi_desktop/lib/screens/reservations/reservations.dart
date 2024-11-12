import 'package:erezervisi_desktop/enums/reservation_status.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/dropdown_item.dart';
import 'package:erezervisi_desktop/models/requests/reservation/get_reservations_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/providers/reservation_provider.dart';
import 'package:erezervisi_desktop/screens/chat/chat_details.dart';
import 'package:erezervisi_desktop/screens/reservations/reservation_details.dart';
import 'package:erezervisi_desktop/shared/components/form/dropdown.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/widgets/action_button.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:erezervisi_desktop/screens/reservations/reservation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

enum ReservationsView { Calendar, List }

class ReservationStatusItem {
  late String label;
  late ReservationStatus status;
  late Color color;

  ReservationStatusItem(
      {required this.label, required this.status, required this.color});
}

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  var reservations = PagedResponse<ReservationGetDto>.empty();
  List<ReservationGetDto> calendarReservations = [];

  var fromController = TextEditingController();
  var toController = TextEditingController();

  DateTime? from;
  DateTime? to;

  num? status;

  var request = GetReservationsRequest.def();
  var calendarRequest = GetReservationsRequest.def();

  late ReservationProvider reservationProvider;

  var initialDateFrom = DateTime(DateTime.now().year, 1, 1);
  var initialDateTo = DateTime(DateTime.now().year, 12, 31);

  int currentPage = 1;
  final int pageSize = 5;

  ReservationsView currentView = ReservationsView.Calendar;

  List<num> selectedReservations = [];

  @override
  void initState() {
    super.initState();

    reservationProvider = context.read<ReservationProvider>();

    loadReservations();
    loadCalendarReservations();
  }

  Future loadCalendarReservations() async {
    calendarRequest.from =
        from?.toIso8601String() ?? initialDateFrom.toIso8601String();
    calendarRequest.to =
        to?.toIso8601String() ?? initialDateTo.toIso8601String();

    var response = await reservationProvider.getCalendar(calendarRequest);

    if (mounted) {
      setState(() {
        calendarReservations = response.reservations;
      });
    }
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

  Future declineReservation(num reservationId) async {
    await reservationProvider.decline(reservationId);

    loadReservations();
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

  void handleFilter() {
    setState(() {
      request.page = 1;
      request.from =
          from?.toIso8601String() ?? initialDateFrom.toIso8601String();
      request.to = to?.toIso8601String() ?? initialDateTo.toIso8601String();
      request.status = statuses
          .where((element) => element.status.index == status)
          .firstOrNull
          ?.status
          .index;

      calendarRequest.from =
          from?.toIso8601String() ?? initialDateFrom.toIso8601String();
      calendarRequest.to =
          to?.toIso8601String() ?? initialDateTo.toIso8601String();

      calendarRequest.status = statuses
          .where((element) => element.status.index == status)
          .firstOrNull
          ?.status
          .index;
    });

    loadReservations();
    loadCalendarReservations();
  }

  void resetFilters() {
    setState(() {
      request.from = initialDateFrom.toIso8601String();
      request.to = initialDateTo.toIso8601String();
      request.status = null;

      from = null;
      to = null;
      status = null;

      fromController.text = "";
      toController.text = "";
    });
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
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
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
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Odustani'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          handleFilter();

                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              CustomTheme.bluePrimaryColor,
                                        ),
                                        child: const Text('Primjeni'),
                                      ),
                                    ],
                                    content: SizedBox(
                                      height: 400,
                                      width: 300,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 35, vertical: 16),
                                            child: Text(
                                              "Filteri",
                                              style:
                                                  CustomTheme.mediumTextStyle,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: fromController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Od:",
                                                    suffixIcon: Icon(
                                                        Icons.calendar_today),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(
                                                          DateTime.now().year),
                                                      lastDate: DateTime(
                                                          DateTime.now().year,
                                                          12,
                                                          31),
                                                    );
                                                    if (pickedDate != null) {
                                                      setState(() {
                                                        from = pickedDate;
                                                        fromController.text =
                                                            DateFormat(Globals
                                                                    .dateFormat)
                                                                .format(from!);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: TextField(
                                                  controller: toController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Do:",
                                                    suffixIcon: Icon(
                                                        Icons.calendar_today),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () async {
                                                    DateTime? pickedDate =
                                                        await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2101),
                                                    );
                                                    if (pickedDate != null) {
                                                      setState(() {
                                                        to = pickedDate;

                                                        toController.text =
                                                            DateFormat(Globals
                                                                    .dateFormat)
                                                                .format(to!);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 700,
                                            child: Dropdown(
                                                outline: true,
                                                padding: 10,
                                                withSearch: false,
                                                value: status,
                                                placeholder: 'Status',
                                                items: statuses
                                                    .map((item) => DropdownItem(
                                                        key: item.status.index,
                                                        value:
                                                            "${item.label} "))
                                                    .toList(),
                                                controller:
                                                    TextEditingController(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    status = value != 0
                                                        ? ReservationStatus
                                                            .values
                                                            .where((item) =>
                                                                item.index ==
                                                                value)
                                                            .first
                                                            .index
                                                        : null;
                                                  });
                                                }),
                                          ),
                                          TextButton(
                                            onPressed: resetFilters,
                                            child: const Text('Očisti'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Filtriraj",
                              style: CustomTheme.sortByTextStyle,
                            ),
                          ),
                        ],
                      ),
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
                    const SizedBox(width: 20),
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
                            "Gost",
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
                            "Od",
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
                            "Do",
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
                            "Status",
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
                                  .any((res) => res == item.id),
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
                    minDate: initialDateFrom,
                    maxDate: initialDateTo,
                    view: CalendarView.month,
                    dataSource: ReservationDataSource(calendarReservations),
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
                  )),
            if (currentView == ReservationsView.Calendar)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                    children: statuses
                        .where(
                            (item) => item.status != ReservationStatus.Unknown)
                        .map(
                          (item) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 20,
                            decoration: BoxDecoration(color: item.color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                item.label,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              )
          ],
        ),
      ),
    );
  }

  _spacer() {
    return const SizedBox(
      width: 20,
    );
  }

  void _openReservationsDialog(
      BuildContext context, ReservationGetDto reservation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReservationDetails(
          reservation: reservation,
          onMessageSend: () {
            Navigate.next(context, AppRoutes.chatDetails.routeName,
                ChatDetails(userId: reservation.guestId), true);
          },
          onDeclined: (value) {
            declineReservation(value);
          },
        );
      },
    );
  }
}

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
      label: "Odbijeno", status: ReservationStatus.Declined, color: Colors.red),
  ReservationStatusItem(
      label: "Otkazano",
      status: ReservationStatus.Cancelled,
      color: Colors.brown),
  ReservationStatusItem(
      label: "Završeno",
      status: ReservationStatus.Completed,
      color: Colors.purple),
];

Color getReservationColor(ReservationGetDto reservation) {
  return statuses
          .where((item) => item.status == reservation.status)
          .firstOrNull
          ?.color ??
      CustomTheme.bluePrimaryColor;
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

  @override
  Color getColor(int index) {
    var reservation = _getReservationData(index);
    return getReservationColor(reservation);
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
