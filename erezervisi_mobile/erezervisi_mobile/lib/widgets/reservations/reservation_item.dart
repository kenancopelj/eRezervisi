import 'package:erezervisi_mobile/enums/reservation_status.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/helpers/helpers.dart';
import 'package:erezervisi_mobile/models/responses/reservation/reservation_by_status_get_dto.dart';
import 'package:erezervisi_mobile/providers/reservation_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReservationItem extends StatefulWidget {
  final ReservationByStatusGetDto reservation;
  final void Function() onStatusChanged;
  const ReservationItem(
      {required this.reservation, required this.onStatusChanged, super.key});

  @override
  State<ReservationItem> createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  late ReservationProvider reservationProvider;

  @override
  void initState() {
    super.initState();

    reservationProvider = context.read<ReservationProvider>();
  }

  Color getColor() {
    switch (widget.reservation.status) {
      case ReservationStatus.Draft:
        return CustomTheme.bluePrimaryColor;
      case ReservationStatus.Confirmed:
        return Colors.green;
      case ReservationStatus.Declined:
        return Colors.red;
      case ReservationStatus.InProgress:
        return Colors.orange;
      case ReservationStatus.Cancelled:
        return Colors.brown;
      case ReservationStatus.Completed:
        return Colors.purple;
      default:
        return Colors.purple;
    }
  }

  String getStatusLabel() {
    switch (widget.reservation.status) {
      case ReservationStatus.Draft:
        return "Kreirano";
      case ReservationStatus.Confirmed:
        return "Potvrđeno";
      case ReservationStatus.InProgress:
        return "U toku";
      case ReservationStatus.Declined:
        return "Odbijeno";
      case ReservationStatus.Cancelled:
        return "Otkazano";
      case ReservationStatus.Completed:
        return "Završeno";
      default:
        return "N/A";
    }
  }

  String getActionLabelBasedOnStatus() {
    switch (widget.reservation.status) {
      case ReservationStatus.Draft:
        return "POTVRDI";
      case ReservationStatus.Confirmed:
        return "OTKAŽI";
      default:
        return "N/A";
    }
  }

  Future changeReservationStatus() async {
    if (widget.reservation.status == ReservationStatus.Draft) {
      await reservationProvider.confirm(widget.reservation.id);
    } else if (widget.reservation.status == ReservationStatus.Confirmed) {
      await reservationProvider.cancel(widget.reservation.id);
    }

    widget.onStatusChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 120,
            color: CustomTheme.bluePrimaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.reservation.accommodationUnit,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getColor(),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            getStatusLabel().toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Period: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "${DateFormat(Globals.dateFormat).format(widget.reservation.from)} - ${DateFormat(Globals.dateFormat).format(widget.reservation.to)}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Broj osoba: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${widget.reservation.totalPeople}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Ukupno: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(Helpers.formatPrice(widget.reservation.totalPrice)),
                      Spacer(),
                      if (widget.reservation.status ==
                              ReservationStatus.Draft ||
                          widget.reservation.status ==
                              ReservationStatus.Confirmed)
                        InkWell(
                          onTap: changeReservationStatus,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              getActionLabelBasedOnStatus(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
