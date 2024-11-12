import 'package:erezervisi_desktop/enums/reservation_status.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/helpers/helpers.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationDetails extends StatelessWidget {
  final ReservationGetDto reservation;
  final void Function()? onMessageSend;
  final void Function(num reservationId)? onDeclined;

  ReservationDetails(
      {super.key,
      required this.reservation,
      this.onMessageSend,
      this.onDeclined});

  final guestFullNameController = TextEditingController();
  final guestContactController = TextEditingController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();
  final numberOfAdultsController = TextEditingController();
  final numberOfChildrenController = TextEditingController();
  final noteController = TextEditingController();

  Color getColor() {
    switch (reservation.status) {
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 500,
        width: 400,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(color: CustomTheme.bluePrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Rezervacija",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        Helpers.getInitials(reservation.guest),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.person_outline),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(reservation.guest)
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.phone_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(reservation.guestContact)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.bed_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(("Objekat:"))
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(reservation.accommodationUnitTitle)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.calendar_month_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(("Od:"))
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(DateFormat(Globals.dateFormat)
                                .format(reservation.from))
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(("Do:")),
                            Text(DateFormat(Globals.dateFormat)
                                .format(reservation.to))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.people_outline),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(("Odrasli:"))
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(reservation.numberOfAdults.toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.child_care_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(("Djeca:")),
                            Text(reservation.numberOfChildren.toString())
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.monetization_on_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(("Cijena:"))
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(Helpers.formatPrice(reservation.totalPrice))
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 90,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: getColor(),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  reservation.status.title.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: CustomTheme.bluePrimaryColor)),
                ),
                width: 600,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (reservation.status != ReservationStatus.Cancelled)
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ConfirmationDialog(
                                          title: 'Odbij rezervaciju',
                                          content:
                                              'Da li ste sigurni da želite odbiti rezervaciju?',
                                          onConfirm: () {
                                            onDeclined!(reservation.id);
                                            Navigator.pop(context);
                                          });
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.close_outlined,
                                  size: 16,
                                )),
                            const Text(
                              "ODBIJ",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 55),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: onMessageSend,
                              icon: const Icon(
                                Icons.message_outlined,
                                size: 16,
                              )),
                          const Text(
                            "POŠALJI PORUKU",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
