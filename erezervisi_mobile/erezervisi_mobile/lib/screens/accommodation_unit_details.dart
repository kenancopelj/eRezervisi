// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/helpers/file_helper.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/favorites_provider.dart';
import 'package:erezervisi_mobile/providers/file_provider.dart';
import 'package:erezervisi_mobile/screens/reservation_details.dart';
import 'package:erezervisi_mobile/screens/reviews.dart';
import 'package:erezervisi_mobile/widgets/home_custom/carousel_indicators.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ObjectDetails extends StatefulWidget {
  final num accommodationUnitId;
  const ObjectDetails({super.key, required this.accommodationUnitId});

  @override
  State<ObjectDetails> createState() => _ObjectDetailsState();
}

class _ObjectDetailsState extends State<ObjectDetails> {
  AccommodationUnitGetDto? accommodationUnit;

  late AccommodationUnitProvider accommodationUnitProvider;
  late FileProvider fileProvider;
  late FavoritesProvider favoritesProvider;

  bool favorite = false;

  List<XFile> images = [];

  @override
  void initState() {
    super.initState();
    accommodationUnitProvider = context.read<AccommodationUnitProvider>();
    fileProvider = context.read<FileProvider>();
    favoritesProvider = context.read<FavoritesProvider>();

    loadAccommodationUnit();
  }

  Future loadAccommodationUnit() async {
    var response =
        await accommodationUnitProvider.getById(widget.accommodationUnitId);

    setState(() {
      accommodationUnit = response;
      favorite = response.favorite;
    });

    for (var i = 0; i < accommodationUnit!.images.length; i++) {
      loadImage(accommodationUnit!.images[i].fileName);
    }
  }

  Future loadImage(String fileName) async {
    var response = await fileProvider.downloadAccommodationUnitImage(fileName);
    var xfile = await getXFileFromBytes(response.bytes, response.fileName);

    setState(() {
      images.add(xfile);
    });
  }

  Future addToFavorites() async {
    var response = await favoritesProvider.add(widget.accommodationUnitId);

    setState(() {
      favorite = true;
    });
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
                      Icons.favorite_outline,
                      color: favorite ? Colors.red : Colors.black,
                    ),
                    onPressed: () => favorite ? addToFavorites() : removeFromFavorites(),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ReservationDetails()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      width: 250,
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
                    items: images.map((i) {
                      return Builder(builder: (_) {
                        return SizedBox(
                          height: 350,
                          width: double.maxFinite,
                          child: Image.file(File(i.path)),
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CarouselIndicators(),
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
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        accommodationUnit!.township.title,
                        style: TextStyle(color: Colors.black),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Reviews()));
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
                      Icon(Icons.monetization_on_outlined, color: Colors.black),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${accommodationUnit!.price}KM",
                        style: CustomTheme.mediumTextStyle,
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/user.png")),
                            borderRadius: BorderRadius.circular(20)),
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
                  Container(
                    width: double.maxFinite,
                    height: 200, // Adjust the height as needed
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(37.422131, -122.084801),
                        zoom: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
