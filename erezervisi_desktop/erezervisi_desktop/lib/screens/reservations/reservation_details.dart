import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_dto.dart';
import 'package:flutter/material.dart';

class ReservationDetails extends StatelessWidget {
  final ReservationGetDto reservation;
  final void Function()? onMessageSend;

  const ReservationDetails(
      {super.key, required this.reservation, this.onMessageSend});

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
                width: 600,
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
                          "Rezervacija",
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
              SizedBox(
                width: 600,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/user.png'), // Zamijeni s pravom slikom
                    ),
                    Column(
                      children: [],
                    )
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
