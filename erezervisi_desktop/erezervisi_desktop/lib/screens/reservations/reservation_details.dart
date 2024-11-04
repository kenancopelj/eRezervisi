import 'package:erezervisi_desktop/enums/reservation_status.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:erezervisi_desktop/shared/components/form/input.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';

class ReservationDetails extends StatelessWidget {
  final ReservationGetDto reservation;
  final void Function()? onMessageSend;

  ReservationDetails(
      {super.key, required this.reservation, this.onMessageSend});

  final guestFullNameController = TextEditingController();
  final guestContactController = TextEditingController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();
  final numberOfAdultsController = TextEditingController();
  final numberOfChildrenController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 300,
        width: 600,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(color: CustomTheme.bluePrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Rezervacija - ${reservation.accommodationUnitTitle}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close_outlined,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          reservation.accommodationUnitThumbnailImage != null
                              ? NetworkImage(Globals.imageBasePath +
                                  reservation.accommodationUnitThumbnailImage!)
                              : AssetImage('assets/images/user.png'),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_outline),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 250,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: TextEditingController(
                                      text: reservation.guest),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 250,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  controller: TextEditingController(
                                      text: reservation.guestContact),
                                ),
                              )
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                controller: TextEditingController(
                                    text: reservation.from.toString()),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                controller: TextEditingController(
                                    text: reservation.to.toString()),
                              ),
                            )
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people_outline),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                controller: TextEditingController(
                                    text:
                                        reservation.numberOfAdults.toString()),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.child_care_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                controller: TextEditingController(
                                    text: reservation.numberOfChildren
                                        .toString()),
                              ),
                            )
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.line_axis_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    controller: TextEditingController(
                                        text: reservation.status.title),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.monetization_on_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    controller: TextEditingController(
                                        text: "${reservation.totalPrice}KM"),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                controller:
                                    TextEditingController(text: "testiranje"),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 600,
                height: 60,
                decoration: BoxDecoration(color: CustomTheme.bluePrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: onMessageSend,
                              icon: Icon(
                                Icons.message_outlined,
                                color: Colors.white,
                              )),
                          Text(
                            "POŠALJI PORUKU",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close_outlined,
                                  color: Colors.white,
                                )),
                            Text(
                              "ZATVORI",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
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
