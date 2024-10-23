// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/helpers/file_helper.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/favorites_provider.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/screens/chat.dart';
import 'package:erezervisi_mobile/screens/chat_details.dart';
import 'package:erezervisi_mobile/screens/reservation_details.dart';
import 'package:erezervisi_mobile/screens/reviews.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/widgets/home_custom/carousel_indicators.dart';
import 'package:erezervisi_mobile/widgets/image/preview_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

import '../shared/navigator/navigate.dart';

class ObjectDetails extends StatefulWidget {
  final num accommodationUnitId;
  const ObjectDetails({super.key, required this.accommodationUnitId});

  @override
  State<ObjectDetails> createState() => _ObjectDetailsState();
}

class _ObjectDetailsState extends State<ObjectDetails> {
  AccommodationUnitGetDto? accommodationUnit;

  late AccommodationUnitProvider accommodationUnitProvider;
  late FavoritesProvider favoritesProvider;
  late UserProvider userProvider;

  int imageIndex = 0;

  bool favorite = false;

  LatLng? _tappedPoint;

  UserGetDto? owner;

  @override
  void initState() {
    super.initState();
    accommodationUnitProvider = context.read<AccommodationUnitProvider>();
    favoritesProvider = context.read<FavoritesProvider>();
    userProvider = context.read<UserProvider>();

    loadAccommodationUnit();
  }

  Future loadAccommodationUnit() async {
    var response =
        await accommodationUnitProvider.getById(widget.accommodationUnitId);

    setState(() {
      accommodationUnit = response;
      favorite = response.favorite;

      _tappedPoint = LatLng(accommodationUnit!.latitude.toDouble(),
          accommodationUnit!.longitude.toDouble());

          print(_tappedPoint);
    });

    loadUser();
  }

  Future loadUser() async {
    var response = await userProvider.getById(accommodationUnit!.ownerId);

    setState(() {
      owner = response;
    });
  }

  Future addToFavorites() async {
    try {
      var response = await favoritesProvider.add(widget.accommodationUnitId);

      setState(() {
        favorite = true;
      });
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }
  }

  Future removeFromFavorites() async {
    var response = await favoritesProvider.remove(widget.accommodationUnitId);

    setState(() {
      favorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return accommodationUnit == null
        ? SizedBox.shrink()
        : Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                iconSize: 14,
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(
                      favorite ? Icons.favorite : Icons.favorite_outline,
                      color: favorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () =>
                        favorite ? removeFromFavorites() : addToFavorites(),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: IconButton(
                    icon: Icon(
                      Icons.message_outlined,
                    ),
                    onPressed: navigateToChat,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    onTap: () {
                      Navigate.next(
                          context,
                          AppRoutes.reservationDetails.routeName,
                          ReservationDetails(
                              accommodationUnitId: widget.accommodationUnitId),
                          true);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 350,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "POŠALJI UPIT",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    disableGesture: false,
                    items: accommodationUnit!.images.map((i) {
                      return Builder(builder: (_) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return PreviewImage(
                                  imageUrl: Globals.imageBasePath + i.fileName,
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            height: 350,
                            width: double.maxFinite,
                            child: Image.network(
                              Globals.imageBasePath + i.fileName,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          imageIndex = index;
                        });
                      },
                      autoPlay: false,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      accommodationUnit!.images.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: imageIndex == index
                              ? CustomTheme.bluePrimaryColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Text(
                          accommodationUnit!.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: CustomTheme.bluePrimaryColor,
                        size: 24,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        accommodationUnit!.township.title,
                        style: TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                        size: 24,
                      ),
                      accommodationUnit?.note != null
                          ? Text(accommodationUnit!.note!)
                          : SizedBox.shrink(),
                      TextButton(
                        onPressed: () {
                          Navigate.next(context, AppRoutes.reviews.routeName,
                              const Reviews(), true);
                        },
                        child:
                            Text("4.8", style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      accommodationUnit!.note ?? "",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${accommodationUnit!.price}KM",
                        style: TextStyle(fontSize: 14),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          children: [
                            owner?.image != null
                                ? Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              Globals.imageBasePath +
                                                  owner!.image!),
                                          fit: BoxFit.contain),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 20),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      owner != null
                                          ? owner!.firstName.substring(0, 1)
                                          : '',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                            Text("@${owner?.firstName}")
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                    child: Text(
                      "Lokacija",
                      style: CustomTheme.mediumTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width - 10,
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: _tappedPoint ?? const LatLng(43.3, 17.807),
                        initialZoom: 13.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: _tappedPoint != null
                              ? [
                                  Marker(
                                    point: _tappedPoint!,
                                    child: const Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  )
                                ]
                              : [],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  navigateToChat() {
    Navigate.next(
        context,
        AppRoutes.chat.routeName,
        ChatDetails(
          userId: accommodationUnit!.ownerId,
        ),
        true);
  }
}
