// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/payment_method.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/reservation/reservation_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/reservation_provider.dart';
import 'package:erezervisi_mobile/screens/home.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ReservationDetails extends StatefulWidget {
  final num accommodationUnitId;
  const ReservationDetails({super.key, required this.accommodationUnitId});

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  bool isPaymentScreen = false;

  late AccommodationUnitProvider accommodationUnitProvider;
  late ReservationProvider reservationProvider;

  AccommodationUnitGetDto? accommodationUnit;

  DateTime? dateFrom;
  DateTime? dateTo;

  int total = 0;

  int numberOfChildren = 0;
  int numberOfAdults = 0;

  int basePrice = 0;

  String rangeText = '';

  int _selectedPaymentMethod = PaymentMethod.Card.index;

  handleDatesChange(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        setState(() {
          dateFrom = args.value.startDate;
          dateTo = args.value.endDate ?? args.value.startDate;

          var range = dateTo!.difference(dateFrom!).inDays;

          total = range * basePrice;

          rangeText =
              '${DateFormat('dd.MM.yyyy').format(args.value.startDate)} - ${DateFormat('dd.MM.yyyy').format(args.value.endDate ?? args.value.startDate)}';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    accommodationUnitProvider = context.read<AccommodationUnitProvider>();
    reservationProvider = context.read<ReservationProvider>();

    loadAccommodationUnit();
  }

  Future loadAccommodationUnit() async {
    var response =
        await accommodationUnitProvider.getById(widget.accommodationUnitId);

    setState(() {
      accommodationUnit = response;
      basePrice = accommodationUnit!.price.toInt();
    });
  }

  resetDates() {
    setState(() {
      dateFrom = null;
      dateTo = null;

      rangeText = '';
      total = 0;
    });
  }

  resetGuests() {
    setState(() {
      numberOfAdults = 0;
      numberOfChildren = 0;
    });
  }

  handleNextStep() {
    if (_selectedPaymentMethod == PaymentMethod.Cash.index) {
      handleSubmit();
    }
  }

  Widget paymentScreen() {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: handleNextStep,
        child: Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              "Dalje",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 35, left: 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 14),
                    onPressed: () {
                      setState(() {
                        isPaymentScreen = false;
                      });
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Način plaćanja",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 30),
            child: Text(
              "Molimo, odaberite jedan od načina plaćanja Vaše rezervacije",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: Row(children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/stripe-logo.png"),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Kartica")
              ]),
              trailing: Radio<int>(
                value: PaymentMethod.Card.index,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListTile(
              title: Row(children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 42,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Gotovina")
              ]),
              trailing: Radio<int>(
                value: PaymentMethod.Cash.index,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isPaymentScreen
        ? paymentScreen()
        : Scaffold(
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
                            "Ukupno: ${total}KM",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: InkWell(
                      onTap: () {
                        setState(() {
                          isPaymentScreen = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: Center(
                            child: Text(
                          "POTVRDI",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 50,
                        child: Text(
                          accommodationUnit?.title ?? '',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      )
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
                                  icon:
                                      Icon(Icons.arrow_back_ios_new, size: 14),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                "Datum",
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: resetDates,
                                child: Text(
                                  "Očisti",
                                  style: TextStyle(
                                      color: CustomTheme.bluePrimaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 400,
                            width: double.maxFinite,
                            margin: EdgeInsets.all(20),
                            child: SfDateRangePicker(
                              initialSelectedRange:
                                  PickerDateRange(dateFrom, dateTo),
                              rangeSelectionColor:
                                  CustomTheme.bluePrimaryColor.withOpacity(0.5),
                              startRangeSelectionColor:
                                  CustomTheme.bluePrimaryColor,
                              onSelectionChanged: handleDatesChange,
                              endRangeSelectionColor:
                                  CustomTheme.bluePrimaryColor,
                              selectionMode: DateRangePickerSelectionMode.range,
                            )),
                        Text(rangeText),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                "Gosti",
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: resetGuests,
                                child: Text(
                                  "Očisti",
                                  style: TextStyle(
                                      color: CustomTheme.bluePrimaryColor),
                                ),
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            "Preko 12 godina",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            if (numberOfAdults - 1 < 0) {
                                              setState(() {
                                                numberOfAdults = 0;
                                              });
                                            } else {
                                              setState(() {
                                                numberOfAdults--;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          )),
                                      Text(
                                        "$numberOfAdults",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              numberOfAdults++;
                                            });
                                          },
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            "Ispod 12 godina",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            if (numberOfChildren - 1 < 0) {
                                              setState(() {
                                                numberOfChildren = 0;
                                              });
                                            } else {
                                              setState(() {
                                                numberOfChildren--;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          )),
                                      Text(
                                        "$numberOfChildren",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              numberOfChildren++;
                                            });
                                          },
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

  Future handleSubmit() async {
    var payload = ReservationCreateDto(
        accommodationUnitId: widget.accommodationUnitId,
        from: dateFrom!,
        to: dateTo!,
        numberOfAdults: numberOfAdults,
        numberOfChildren: numberOfChildren,
        paymenthMethod: _selectedPaymentMethod);

    try {
      await reservationProvider.create(payload);

      if (mounted) {
        Globals.notifier
            .setInfo("Uspješno kreirana rezervacija", ToastType.Success);
        Navigate.next(context, AppRoutes.home.routeName, Home());
      }
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }
  }
}
