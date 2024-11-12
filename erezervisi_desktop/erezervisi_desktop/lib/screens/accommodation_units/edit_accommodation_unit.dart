import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erezervisi_desktop/enums/input_type.dart';
import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/models/dropdown_item.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/accommodation_unit_update_dto.dart';
import 'package:erezervisi_desktop/models/requests/accommodation_unit/policy_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/category/get_all_categories_request.dart';
import 'package:erezervisi_desktop/models/requests/category/get_categories_request.dart';
import 'package:erezervisi_desktop/models/requests/image/image_create_dto.dart';
import 'package:erezervisi_desktop/models/requests/townshp/get_all_townships_request.dart';
import 'package:erezervisi_desktop/models/requests/townshp/get_townships_request.dart';
import 'package:erezervisi_desktop/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/providers/category_provider.dart';
import 'package:erezervisi_desktop/providers/township_provider.dart';
import 'package:erezervisi_desktop/screens/accommodation_units/accommodation_units.dart';
import 'package:erezervisi_desktop/shared/components/form/button.dart';
import 'package:erezervisi_desktop/shared/components/form/checkbox.dart';
import 'package:erezervisi_desktop/shared/components/form/dropdown.dart';
import 'package:erezervisi_desktop/shared/components/form/input.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/shared/navigator/navigate.dart';
import 'package:erezervisi_desktop/shared/navigator/route_list.dart';
import 'package:erezervisi_desktop/shared/style.dart';
import 'package:erezervisi_desktop/shared/validators/accommodation_unit/create.dart';
import 'package:erezervisi_desktop/widgets/image/preview_image.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditAccommodationUnit extends StatefulWidget {
  final num accommodationUnitId;
  const EditAccommodationUnit({super.key, required this.accommodationUnitId});

  @override
  State<EditAccommodationUnit> createState() => _EditAccommodationUnitState();
}

class _EditAccommodationUnitState extends State<EditAccommodationUnit> {
  AccommodationUnitGetDto? accommodationUnit;

  final formKey = GlobalKey<FormState>();

  var validator = AccommodationUnitCreateValidator();

  late AccommodationUnitProvider provider;
  late CategoryProvider categoryProvider;
  late TownshipProvider townshipProvider;

  List<DropdownItem> categories = [];
  List<DropdownItem> townships = [];
  List<ImageCreateDto> images = [];

  var categoriesRequest = GetCategoriesRequest.def();
  var townshipsRequest = GetTownshipsRequest.def();

  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var capacityController = TextEditingController();
  var addressController = TextEditingController();

  num? categoryId;
  num? townshipId;

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController townshipController = TextEditingController();

  num? latitude;
  num? longitude;

  bool alcoholAllowed = false;
  bool oneNightOnly = false;
  bool birthdayPartiesAllowed = false;
  bool hasPool = false;

  LatLng? _tappedPoint;

  @override
  void initState() {
    super.initState();

    provider = context.read<AccommodationUnitProvider>();
    categoryProvider = context.read<CategoryProvider>();
    townshipProvider = context.read<TownshipProvider>();

    loadAccommodationUnit();
    loadCategories();
    loadTownships();
  }

  Future loadAccommodationUnit() async {
    var response = await provider.getById(widget.accommodationUnitId);
    if (mounted) {
      setState(() {
        accommodationUnit = response;

        titleController.text = accommodationUnit!.title;
        priceController.text = accommodationUnit!.price.toStringAsFixed(2);
        categoryId = accommodationUnit!.categoryId;
        townshipId = accommodationUnit!.township.id;
        addressController.text = accommodationUnit!.address;
        capacityController.text =
            accommodationUnit!.policy?.capacity.toString() ?? "";
        oneNightOnly = accommodationUnit!.policy?.oneNightOnly ?? false;
        alcoholAllowed = accommodationUnit!.policy?.alcoholAllowed ?? false;
        birthdayPartiesAllowed =
            accommodationUnit!.policy?.birthdayPartiesAllowed ?? false;
        hasPool = accommodationUnit!.policy?.hasPool ?? false;
        latitude = accommodationUnit!.latitude;
        longitude = accommodationUnit!.longitude;

        _tappedPoint = LatLng(latitude!.toDouble(), longitude!.toDouble());

        for (var image in accommodationUnit!.images) {
          images.add(ImageCreateDto(
              id: image.id,
              isThumbnail: false,
              imageUrl: Globals.imageBasePath + image.fileName,
              imageFileName: image.fileName));
        }
      });
    }
  }

  Future loadCategories() async {
    var response =
        await categoryProvider.getAll(GetAllCategoriesRequest(searchTerm: ''));

    if (mounted) {
      setState(() {
        for (var item in response.categories) {
          categories.add(DropdownItem(key: item.id, value: item.title));
        }
      });
    }
  }

  Future loadTownships() async {
    var response =
        await townshipProvider.getAll(GetAllTownshipsRequest(searchTerm: ''));

    if (mounted) {
      setState(() {
        for (var item in response.townships) {
          townships.add(DropdownItem(key: item.id, value: item.title));
        }
      });
    }
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: Globals.imageQuality,
      maxHeight: Globals.imageMaxHeight,
      maxWidth: Globals.imageMaxWidth,
    );
    if (image != null && mounted) {
      var bytes = await image.readAsBytes();
      var base64image = base64Encode(bytes);
      setState(() {
        images.add(ImageCreateDto(
          imageBase64: base64image,
          imageFileName: image.name,
          image: image,
          isThumbnail: false,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: accommodationUnit == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text("Objekti / ${accommodationUnit!.title}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20)),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  images.isNotEmpty
                                      ? SizedBox(
                                          width: 600,
                                          height: 300,
                                          child: images.first.imageUrl != null
                                              ? Image.network(
                                                  images.first.imageUrl!,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(
                                                      images.first.image!.path),
                                                  fit: BoxFit.cover,
                                                ),
                                        )
                                      : Container(
                                          width: 600,
                                          height: 300,
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.image,
                                            size: 100,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 120,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemCount:
                                          images.where((i) => !i.delete).length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => PreviewImage(
                                                image: images[index].image,
                                                imageUrl:
                                                    images[index].imageUrl,
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              if (images[index].imageUrl !=
                                                  null)
                                                Image.network(
                                                  images[index].imageUrl!,
                                                  width: 60,
                                                  height: 60,
                                                )
                                              else
                                                Image.file(
                                                  File(images[index]
                                                      .image!
                                                      .path),
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.delete_outline),
                                                onPressed: () {
                                                  setState(() {
                                                    images[index].delete = true;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          Style.inputBackgroundColor),
                                      elevation: WidgetStateProperty.all(0),
                                      padding: WidgetStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 12.0,
                                              horizontal: 16.0)),
                                      side: WidgetStateProperty.all(
                                          const BorderSide(
                                              color:
                                                  Color.fromARGB(100, 0, 0, 0),
                                              width: 1)),
                                    ),
                                    onPressed: pickImage,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Style.primaryColor100,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('Dodaj sliku',
                                            style: TextStyle(
                                                color: Style.primaryColor100)),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      children: [
                                        Text("Lokacija:"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 270,
                                    width: 600,
                                    child: FlutterMap(
                                      options: MapOptions(
                                        initialCenter: _tappedPoint ??
                                            const LatLng(43.3, 17.807),
                                        initialZoom: 13.0,
                                        onTap: _handleTap,
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
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Input(
                                    labelIcon: const Icon(Icons.abc),
                                    controller: titleController,
                                    validator: validator.required,
                                    label: "Naziv objekta:",
                                    hintText: "Unesite naziv Vašeg objekta",
                                  ),
                                  Input(
                                    labelIcon: const Icon(
                                        Icons.monetization_on_outlined),
                                    controller: priceController,
                                    label: "Cijena (po noćenju)",
                                    validator: validator.numberOnly,
                                    hintText: "0KM",
                                  ),
                                  Dropdown(
                                    labelIcon:
                                        const Icon(Icons.category_outlined),
                                    label: 'Kategorija',
                                    controller: categoryController,
                                    value: categoryId,
                                    placeholder: '',
                                    hintText: 'e.g. Privatna kuća',
                                    items: categories,
                                    onChanged: (value) {
                                      setState(() {
                                        categoryId = value;
                                      });
                                    },
                                  ),
                                  Dropdown(
                                    labelIcon: const Icon(
                                        Icons.location_city_outlined),
                                    label: 'Mjesto',
                                    controller: townshipController,
                                    value: townshipId,
                                    placeholder: '',
                                    hintText: 'e.g. Mostar',
                                    items: townships,
                                    onChanged: (value) {
                                      setState(() {
                                        townshipId = value;
                                      });
                                    },
                                  ),
                                  Input(
                                    labelIcon: const Icon(Icons.location_city),
                                    controller: addressController,
                                    label: "Adresa",
                                    validator: validator.required,
                                    hintText: "e.g. Ulica 13, Mostar",
                                  ),
                                  Input(
                                    controller: capacityController,
                                    label: "Kapacitet objekta",
                                    hintText: "e.g. 5 osoba",
                                    validator: validator.required,
                                    type: InputType.Number,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 55, top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.info),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Opcije:")
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 130,
                                    child: Column(
                                      children: [
                                        FormSwitch(
                                            value: oneNightOnly,
                                            onChange: (value) => {
                                                  setState(() {
                                                    oneNightOnly = value;
                                                  })
                                                },
                                            label: "Samo jedno noćenje"),
                                        FormSwitch(
                                            value: alcoholAllowed,
                                            onChange: (value) => {
                                                  setState(() {
                                                    alcoholAllowed = value;
                                                  })
                                                },
                                            label: "Alkohol dozvoljen"),
                                        FormSwitch(
                                            value: birthdayPartiesAllowed,
                                            onChange: (value) => {
                                                  setState(() {
                                                    birthdayPartiesAllowed =
                                                        value;
                                                  })
                                                },
                                            label: "Proslave rođendana"),
                                        FormSwitch(
                                            value: hasPool,
                                            onChange: (value) => {
                                                  setState(() {
                                                    hasPool = value;
                                                  })
                                                },
                                            label: "Bazen"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        child: Button(
                                          label: "SAČUVAJ",
                                          onClick: handleSubmit,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _handleTap(TapPosition tapPosition, LatLng latLng) {
    setState(() {
      _tappedPoint = latLng;
      latitude = latLng.latitude;
      longitude = latLng.longitude;
    });
  }

  bool validate() {
    return formKey.currentState!.validate();
  }

  Future handleSubmit() async {
    if (!validate()) {
      return;
    }

    if (images.isEmpty) {
      Globals.notifier.setInfo("Slika objekta je obavezna!", ToastType.Warning);
      return;
    }

    var thumbnailSelected =
        images.where((x) => x.isThumbnail).firstOrNull != null ? true : false;

    if (!thumbnailSelected) {
      setState(() {
        images.first.isThumbnail = true;
      });
    }

    if (latitude == null || longitude == null) {
      Globals.notifier
          .setInfo("Lokacija objekta je obavezna!", ToastType.Warning);
      return;
    }

    var payload = AccommodationUnitUpdateDto(
        id: accommodationUnit!.id,
        title: titleController.text,
        price: num.parse(priceController.text),
        policy: PolicyCreateDto(
            alcoholAllowed: alcoholAllowed,
            capacity: num.parse(capacityController.text),
            oneNightOnly: oneNightOnly,
            birthdayPartiesAllowed: birthdayPartiesAllowed,
            hasPool: hasPool),
        categoryId: categoryId!,
        files: images,
        townshipId: townshipId!,
        latitude: latitude!,
        longitude: longitude!,
        address: addressController.text);

    try {
      var response = await provider.update(payload);

      if (mounted) {
        Navigator.pop(context, response);
      }
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      } else {
        if (mounted) {
          Navigate.next(context, AppRoutes.accommodationUnits.routeName,
              const AccommodationUnits());
        }
      }
    }
  }
}
