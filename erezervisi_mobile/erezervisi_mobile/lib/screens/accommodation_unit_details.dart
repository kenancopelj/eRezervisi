// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/accommodation_unit_status.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/helpers/helpers.dart';
import 'package:erezervisi_mobile/models/requests/review/review_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/providers/favorites_provider.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/screens/chat_details.dart';
import 'package:erezervisi_mobile/screens/reservation_details.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/widgets/home_custom/item_card_list.dart';
import 'package:erezervisi_mobile/widgets/image/preview_image.dart';
import 'package:erezervisi_mobile/widgets/reviews_custom/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  bool reviewAllowed = false;

  double rating = 0.0;

  List<ReviewGetDto> reviews = [];

  LatLng? _tappedPoint;

  UserGetDto? owner;

  num averageRating = 0;

  var reviewNoteController = TextEditingController();

  List<AccommodationUnitGetDto> recommendedUnits = [];

  @override
  void initState() {
    super.initState();
    accommodationUnitProvider = context.read<AccommodationUnitProvider>();
    favoritesProvider = context.read<FavoritesProvider>();
    userProvider = context.read<UserProvider>();

    loadAccommodationUnit();
  }

  Future checkIsAllowedToReview() async {
    var response = await accommodationUnitProvider
        .checkIsAllowedToReview(accommodationUnit!.id);

    setState(() {
      reviewAllowed = response;
    });
  }

  Future getReviews() async {
    var response =
        await accommodationUnitProvider.getAllReviews(accommodationUnit!.id);

    setState(() {
      reviews = response.reviews;
      averageRating = response.average;
    });
  }

  Future markAsViewed() async {
    await accommodationUnitProvider.view(accommodationUnit!.id);
  }

  Future loadAccommodationUnit() async {
    var response =
        await accommodationUnitProvider.getById(widget.accommodationUnitId);

    setState(() {
      accommodationUnit = response;
      favorite = response.favorite;

      _tappedPoint = LatLng(accommodationUnit!.latitude.toDouble(),
          accommodationUnit!.longitude.toDouble());
    });

    loadUser();
    markAsViewed();
    checkIsAllowedToReview();
    getReviews();
    getRecommendedUnits();
  }

  Future getRecommendedUnits() async {
    var response = await accommodationUnitProvider
        .getRecommended(widget.accommodationUnitId);

    setState(() {
      recommendedUnits = response;
    });
  }

  Future loadUser() async {
    var response = await userProvider.getById(accommodationUnit!.ownerId);

    setState(() {
      owner = response;
    });
  }

  Future addToFavorites() async {
    try {
      setState(() {
        favorite = true;
      });

      var response = await favoritesProvider.add(widget.accommodationUnitId);
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }
  }

  Future removeFromFavorites() async {
    setState(() {
      favorite = false;
    });

    var response = await favoritesProvider.remove(widget.accommodationUnitId);
  }

  Future createReview() async {
    await accommodationUnitProvider.review(widget.accommodationUnitId,
        ReviewCreateDto(rating: rating, note: reviewNoteController.text));

    setState(() {
      rating = 0.0;
      reviewNoteController.text = "";
    });

    getReviews();
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
            bottomNavigationBar: accommodationUnit!.status ==
                    AccommodationUnitStatus.Active
                ? BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: [
                      BottomNavigationBarItem(
                        icon: IconButton(
                            icon: Icon(
                              favorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color:
                                  favorite == true ? Colors.red : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                favorite == true
                                    ? removeFromFavorites()
                                    : addToFavorites();
                              });
                            }),
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
                                    accommodationUnitId:
                                        widget.accommodationUnitId),
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        label: '',
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height +
                    reviews.length * 140 +
                    900 +
                    (reviewAllowed &&
                            accommodationUnit!.status ==
                                AccommodationUnitStatus.Active
                        ? 250
                        : 0),
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
                                    imageUrl:
                                        Globals.imageBasePath + i.fileName,
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
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Text(
                              accommodationUnit!.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24),
                            ),
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
                          "${accommodationUnit!.address}, ${accommodationUnit!.township.title}",
                          style: TextStyle(color: Colors.black),
                        ),
                        Spacer(),
                        if (reviews.isNotEmpty)
                          Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                            size: 24,
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        if (reviews.isNotEmpty)
                          Text(averageRating.toStringAsFixed(1),
                              style: TextStyle(color: Colors.black)),
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
                          Helpers.formatPrice(accommodationUnit!.price),
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
                              SizedBox(
                                height: 8,
                              ),
                              Text("@${owner?.firstName} ${owner?.lastName}")
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                      child: Text(
                        "Mogućnosti:",
                        style: CustomTheme.mediumTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.wine_bar_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Alkohol dozvoljen",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              accommodationUnit!.policy!.alcoholAllowed
                                  ? Icon(Icons.check)
                                  : Icon(Icons.remove),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.celebration_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Rođendanske proslave",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              accommodationUnit!.policy!.birthdayPartiesAllowed
                                  ? Icon(Icons.check)
                                  : Icon(Icons.remove_outlined),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.pool_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Bazen",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              accommodationUnit!.policy!.hasPool
                                  ? Icon(Icons.check)
                                  : Icon(Icons.remove_outlined),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.bed_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Samo jedno noćenje",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                              accommodationUnit!.policy!.oneNightOnly
                                  ? Icon(Icons.check)
                                  : Icon(Icons.remove_outlined),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.people_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Kapacitet: ${accommodationUnit!.policy!.capacity} osoba",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                      child: Text(
                        "Lokacija:",
                        style: CustomTheme.mediumTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width - 10,
                      child: FlutterMap(
                        options: MapOptions(
                          interactionOptions:
                              InteractionOptions(flags: InteractiveFlag.none),
                          keepAlive: false,
                          initialCenter:
                              _tappedPoint ?? const LatLng(43.3, 17.807),
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
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                      child: Text(
                        "Recenzije:",
                        style: CustomTheme.mediumTextStyle,
                      ),
                    ),
                    if (reviewAllowed &&
                        accommodationUnit!.status ==
                            AccommodationUnitStatus.Active)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Unesite vašu recenziju',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 24,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (value) {
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '($rating)',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: reviewNoteController,
                              maxLines: 4,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: createReview,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Style.primaryColor100,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: Text(
                                  'Pošalji recenziju',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    if (reviews.isNotEmpty)
                      Column(
                          children: reviews
                              .map((review) => ReviewItem(
                                    review: review,
                                  ))
                              .toList()),
                    if (reviews.isEmpty)
                      SizedBox(
                          height: 150,
                          child: Center(child: Text("Nema recenzija"))),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Preporučeno',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ItemCardList(
                        items: recommendedUnits,
                      ),
                    ),
                  ],
                ),
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
