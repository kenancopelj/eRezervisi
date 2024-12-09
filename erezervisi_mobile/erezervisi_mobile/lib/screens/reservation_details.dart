// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/payment_method.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/payment/payment_intent_request.dart';
import 'package:erezervisi_mobile/models/requests/reservation/check_availability.dart';
import 'package:erezervisi_mobile/models/requests/reservation/reservation_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/payment/payment_intent_dto.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/payment_provider.dart';
import 'package:erezervisi_mobile/providers/reservation_provider.dart';
import 'package:erezervisi_mobile/screens/home.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  bool showPayementScreen = false;
  bool showSuccessScreen = false;

  late AccommodationUnitProvider accommodationUnitProvider;
  late ReservationProvider reservationProvider;
  late PaymentProvider paymentProvider;

  AccommodationUnitGetDto? accommodationUnit;

  DateTime? dateFrom;
  DateTime? dateTo;

  int total = 0;

  int numberOfChildren = 0;
  int numberOfAdults = 0;
  int basePrice = 0;

  int totalDays = 0;
  int totalPeople = 0;

  bool objectReserved = false;
  bool formSubmitted = false;

  String rangeText = '';

  int _selectedPaymentMethod = PaymentMethods.Card.index;

  handleDatesChange(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        setState(() {
          dateFrom = DateTime.tryParse(args.value.startDate.toString());
          dateTo = DateTime.tryParse(args.value.endDate.toString()) ?? dateFrom;
        });

        setState(() {
          totalDays = dateTo!.difference(dateFrom!).inDays;
        });

        if (accommodationUnit!.policy!.oneNightOnly && totalDays > 1) {
          return;
        }

        if (dateFrom!.isBefore(DateTime.now()) ||
            dateTo!.isBefore(DateTime.now())) {
          return;
        }

        setState(() {
          dateFrom = args.value.startDate;
          dateTo = args.value.endDate ?? args.value.startDate;

          var range = dateTo!.difference(dateFrom!).inDays + 1;

          total = range * basePrice;

          rangeText =
              '${DateFormat('dd.MM.yyyy').format(args.value.startDate)} - ${DateFormat('dd.MM.yyyy').format(args.value.endDate ?? args.value.startDate)}';
        });

        checkAvailability();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    accommodationUnitProvider = context.read<AccommodationUnitProvider>();
    reservationProvider = context.read<ReservationProvider>();
    paymentProvider = context.read<PaymentProvider>();

    loadAccommodationUnit();
  }

  Future checkAvailability() async {
    var isReserved = await reservationProvider.checkAvailability(
        accommodationUnit!.id, CheckAvailability(from: dateFrom!, to: dateTo!));

    if (isReserved) {
      resetDates();

      setState(() {
        objectReserved = isReserved;
      });
    }
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

  handleNextStep() async {
    if (_selectedPaymentMethod == PaymentMethods.Cash.index) {
      handleSubmit();
    } else {
      var paymentIntent = await paymentProvider
          .create(PaymentIntentRequest(amount: total * 100));

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent.clientSecret,
              merchantDisplayName: 'eRezervisi',
              billingDetails: BillingDetails(
                  address: Address(
                      city: accommodationUnit!.township.title,
                      country: 'BA',
                      line1: '',
                      line2: '',
                      postalCode: '',
                      state: ''))));

      if (mounted) {
        displayPaymentSheet(context, paymentIntent);
      }
    }
  }

  void displayPaymentSheet(
      BuildContext context, PaymentIntentDto paymentIntent) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        handleSubmit();
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      if (e.toString().contains("cancel")) {
        if (context.mounted) {
          Globals.notifier.setInfo("Plaćanje otkazano!", ToastType.Info);
        }
      }
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
              "POTVRDI",
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
                        showPayementScreen = false;
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
              title: Row(children: [Text("Kartica")]),
              trailing: Radio<int>(
                value: PaymentMethods.Card.index,
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
              title: Row(children: [Text("Gotovina")]),
              trailing: Radio<int>(
                value: PaymentMethods.Cash.index,
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
    return accommodationUnit == null
        ? SizedBox.shrink()
        : showPayementScreen
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
                              formSubmitted = true;
                            });

                            var capacity = accommodationUnit!.policy!.capacity;

                            var totalPeople = numberOfAdults + numberOfChildren;

                            if (totalPeople == 0) {
                              return;
                            }

                            if (numberOfAdults == 0 && numberOfChildren > 0) {
                              return;
                            }

                            if (totalPeople > capacity) {
                              return;
                            }

                            if (dateFrom == null || dateTo == null) {
                              return;
                            }

                            setState(() {
                              showPayementScreen = true;
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                                      icon: Icon(Icons.arrow_back_ios_new,
                                          size: 14),
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
                                height: 300,
                                width: double.maxFinite,
                                margin: EdgeInsets.all(20),
                                child: SfDateRangePicker(
                                  initialSelectedRange:
                                      PickerDateRange(dateFrom, dateTo),
                                  rangeSelectionColor: CustomTheme
                                      .bluePrimaryColor
                                      .withOpacity(0.5),
                                  startRangeSelectionColor:
                                      CustomTheme.bluePrimaryColor,
                                  onSelectionChanged: handleDatesChange,
                                  endRangeSelectionColor:
                                      CustomTheme.bluePrimaryColor,
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                )),
                            Text(rangeText),
                            if (accommodationUnit!.policy!.oneNightOnly &&
                                totalDays > 1)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Objekat dozvoljava samo jedno noćenje",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            if ((dateFrom != null &&
                                    dateFrom!.isBefore(DateTime.now())) ||
                                (dateTo != null &&
                                    dateTo!.isBefore(DateTime.now())))
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Datum mora biti u budućnosti",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            if (objectReserved)
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Datum mora biti u budućnosti",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            if (formSubmitted &&
                                (dateFrom == null || dateTo == null))
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Odaberite period rezervacije!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
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
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "Preko 12 godina",
                                                style: TextStyle(
                                                    color: Colors.grey),
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

                                                setState(() {
                                                  totalPeople = numberOfAdults +
                                                      numberOfChildren;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              )),
                                          Text(
                                            "$numberOfAdults",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  numberOfAdults++;
                                                  totalPeople = numberOfAdults +
                                                      numberOfChildren;
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
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "Ispod 12 godina",
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                                setState(() {
                                                  totalPeople = numberOfAdults +
                                                      numberOfChildren;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              )),
                                          Text(
                                            "$numberOfChildren",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  numberOfChildren++;
                                                  totalPeople = numberOfAdults +
                                                      numberOfChildren;
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
                            if (formSubmitted && totalPeople == 0)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Minimalan broj osoba na rezervaciji je 1!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            if (numberOfAdults == 0 && numberOfChildren > 0)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Na rezervaciji mora biti barem jedna odrasla osoba!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            if (totalPeople >
                                accommodationUnit!.policy!.capacity)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Maksimalan broj osoba je ${accommodationUnit!.policy!.capacity}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
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
        paymenthMethod: _selectedPaymentMethod + 1);

    try {
      await reservationProvider.create(payload);

      if (mounted) {
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
