// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReservationDetails extends StatefulWidget {
  const ReservationDetails({super.key});

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                height: 50,
                margin: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ukupno: 35KM",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20, right: 10),
                child: Center(child: Text("POTVRDI")),
              ),
              label: '')
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 50,
                    child: Text("Villa Mostar"))
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20, left: 20),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, size: 14),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          "Datum",
                          style: TextStyle(color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          "Očisti",
                          style: TextStyle(color: CustomTheme.bluePrimaryColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 400,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(20),
                      child: SfDateRangePicker(
                        initialSelectedRange: PickerDateRange(
                            DateTime(2023, 8, 22), DateTime.now()),
                        rangeSelectionColor:
                            CustomTheme.bluePrimaryColor.withOpacity(0.5),
                        startRangeSelectionColor: CustomTheme.bluePrimaryColor,
                        endRangeSelectionColor: CustomTheme.bluePrimaryColor,
                        selectionMode: DateRangePickerSelectionMode.range,
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          "Gosti",
                          style: TextStyle(color: Colors.black),
                        ),
                        Spacer(),
                        Text(
                          "Očisti",
                          style: TextStyle(color: CustomTheme.bluePrimaryColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      elevation: 2.0,
                      child: SizedBox(
                        height: 50,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Odrasli",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Preko 12 godina",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    )),
                                Text(
                                  "2",
                                  style: TextStyle(color: Colors.black),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      elevation: 2.0,
                      child: SizedBox(
                        height: 50,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Djeca",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "Ispod 12 godina",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                    )),
                                Text(
                                  "2",
                                  style: TextStyle(color: Colors.black),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    )),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
