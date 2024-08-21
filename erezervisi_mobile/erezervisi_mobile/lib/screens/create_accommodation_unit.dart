import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/input_type.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/accommodation_unit_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/policy_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/image/image_create_dto.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/shared/components/form/checkbox.dart';
import 'package:erezervisi_mobile/shared/components/form/input.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/shared/validators/accommodation_unit/create.dart';
import 'package:erezervisi_mobile/widgets/image/preview_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class CreateAccommodationUnitScreen extends StatefulWidget {
  const CreateAccommodationUnitScreen({super.key});

  @override
  State<CreateAccommodationUnitScreen> createState() =>
      _CreateAccommodationUnitScreenState();
}

class _CreateAccommodationUnitScreenState
    extends State<CreateAccommodationUnitScreen> {
  final formKey = GlobalKey<FormState>();

  late AccommodationUnitProvider provider;

  var validator = AccommodationUnitCreateValidator();

  var titleController = TextEditingController();
  var shortTitleController = TextEditingController();
  var priceController = TextEditingController();
  var noteController = TextEditingController();
  var capacityController = TextEditingController();

  late num categoryId;
  late num townshipId;
  List<ImageCreateDto> images = [];

  bool alcoholAllowed = false;
  bool oneNightOnly = false;
  bool birthdayPartiesAllowed = false;
  bool hasPool = false;

  num latitude = 0;
  num longitude = 0;

  bool validated = false;
  int step = 1;

  @override
  void initState() {
    super.initState();

    provider = context.read<AccommodationUnitProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: validated
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (validated && step == 2)
              TextButton(
                onPressed: () {
                  setState(() {
                    step = 1;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text("Nazad"),
                ),
              )
            else
              const SizedBox.shrink(),
            TextButton(
              onPressed: () {
                if (step == 2) {
                  handleSubmit();
                  return;
                }
                if (validate()) {
                  setState(() {
                    validated = true;
                    step = 2;
                  });
                }
              },
              child: Text(step == 1 ? "Dalje" : "Završi"),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: validated && step == 2
                    ? Column(
                        children: [thirdPage(), lastPage()],
                      )
                    : Column(children: pages()))));
  }

  List<Widget> pages() {
    return [firstPage(), secondPage()];
  }

  Widget headerText() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Kreirajte novi objekat",
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }

  Widget pageHeader() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        child: Column(
          children: [
            headerText(),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Unesite detalje Vašeg objekta",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget firstPage() {
    return Column(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            children: [
              headerText(),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Unesite detalje Vašeg objekta",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        )
      ]),
      Column(
        children: [
          const SizedBox(height: 30),
          Input(
            controller: titleController,
            validator: validator.required,
            label: "Naziv",
            hintText: "Unesite naziv Vašeg objekta",
          ),
          Input(
            controller: shortTitleController,
            validator: validator.required,
            label: "Kratki naziv",
            hintText: "e.g. V-MO",
          ),
          Input(
            controller: priceController,
            validator: validator.required,
            label: "Cijena (po noćenju)",
            hintText: "0KM",
          ),
          Input(
            controller: noteController,
            validator: validator.required,
            label: "Adresa",
            hintText: "e.g. Ulica 13, Mostar",
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      )
    ]);
  }

  Widget secondPage() {
    return Column(children: [
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Odredite parametre Vašeg objekta",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        )
      ]),
      Column(
        children: [
          FormSwitch(
              value: alcoholAllowed,
              onChange: handleAlcoholAllowedChange,
              label: "Alkohol dozvoljen"),
          const SizedBox(
            height: 15,
          ),
          Input(
            controller: capacityController,
            validator: validator.required,
            label: "Kapacitet objekta",
            hintText: "e.g. 5 osoba",
            type: InputType.Number,
          ),
          const SizedBox(
            height: 15,
          ),
          FormSwitch(
              value: oneNightOnly,
              onChange: handleOneNightOnlyChange,
              label: "Samo jedno noćenje"),
          const SizedBox(
            height: 15,
          ),
          FormSwitch(
              value: birthdayPartiesAllowed,
              onChange: handleBirthdayPartiesAllowedChange,
              label: "Dozvoljene proslave rođendana"),
          const SizedBox(
            height: 15,
          ),
          FormSwitch(
              value: hasPool,
              onChange: handleHasPoolChange,
              label: "Sa bazenom"),
        ],
      )
    ]);
  }

  Widget thirdPage() {
    return Column(children: [
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Unesite slike Vašeg objekta",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        )
      ]),
      Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Style
                  .inputBackgroundColor), // Replace with your desired color
              elevation: WidgetStateProperty.all(0), // Remove shadow
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0)), // Adjust padding as needed
              side: WidgetStateProperty.all(const BorderSide(
                  color: Color.fromARGB(100, 0, 0, 0), width: 1)), // Add border
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(8.0)),
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: 150,
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    Style.inputBackgroundColor),
                                elevation: WidgetStateProperty.all(0),
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0)),
                              ),
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: Globals.imageQuality,
                                    maxHeight: Globals.imageMaxHeight,
                                    maxWidth: Globals.imageMaxWidth);
                                if (image != null && mounted) {
                                  var bytes = await image.readAsBytes();
                                  var base64image = base64Encode(bytes);

                                  setState(() {
                                    images.add(ImageCreateDto(
                                        imageBase64: base64image,
                                        imageFileName: image.name,
                                        image: image,
                                        isThumbnail: false));
                                  });

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: Style.primaryColor100,
                                      )),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: Text('Kamera',
                                          style: TextStyle(
                                            color: Style.primaryColor100,
                                          ))),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    Style.inputBackgroundColor),
                                elevation: WidgetStateProperty.all(0),
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0)),
                              ),
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: Globals.imageQuality,
                                    maxHeight: Globals.imageMaxHeight,
                                    maxWidth: Globals.imageMaxWidth);
                                if (image != null && mounted) {
                                  var bytes = await image.readAsBytes();
                                  var base64image = base64Encode(bytes);

                                  setState(() {
                                    images.add(ImageCreateDto(
                                        imageBase64: base64image,
                                        imageFileName: image.name,
                                        image: image,
                                        isThumbnail: false));
                                  });

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: Style.primaryColor100,
                                      )),
                                  const SizedBox(width: 8),
                                  Expanded(
                                      child: Text('Galerija',
                                          style: TextStyle(
                                            color: Style.primaryColor100,
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                                FocusScope.of(context).unfocus();
                              }),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_a_photo_outlined,
                  color: Style.primaryColor100,
                ),
                const SizedBox(width: 8),
                Text('Dodaj sliku',
                    style: TextStyle(color: Style.primaryColor100)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: images.length > 2 ? images.length * 250 : 125,
            child: GridView.count(
                crossAxisCount: 2,
                children: images
                    .map(
                      (image) => InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return PreviewImage(
                                image: image.image!,
                              );
                            },
                          );
                        },
                        child: Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: const Center(
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          key: Key(image.imageFileName),
                          onDismissed: (direction) {
                            setState(() {
                              images.removeWhere((x) =>
                                  x.imageFileName == image.imageFileName);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: Image.file(
                              fit: BoxFit.contain,
                              File(image.image!.path),
                              width: 170,
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList() as List<Widget>),
          ),
        ],
      )
    ]);
  }

  Widget lastPage() {
    return Column(children: [
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Odaberite thumbnail sliku Vašeg objekta",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        )
      ]),
      Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 500,
            child: GridView.count(
                crossAxisSpacing: 15,
                crossAxisCount: 2,
                children: images.isEmpty
                    ? [const Text("Nema upload-ovanih slika!")]
                    : images
                        .map(
                          (image) => InkWell(
                            onTap: () {
                              setState(() {
                                var previousThumbnail = images
                                    .where((x) => x.isThumbnail)
                                    .firstOrNull;

                                if (previousThumbnail != null) {
                                  previousThumbnail.isThumbnail = false;
                                }

                                image.isThumbnail = true;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: image.isThumbnail
                                      ? Border.all(color: Style.secondaryColor)
                                      : null,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.file(
                                fit: BoxFit.contain,
                                File(image.image!.path),
                                width: 150,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                            ),
                          ),
                        )
                        .toList() as List<Widget>),
          ),
        ],
      )
    ]);
  }

  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      spacing: const EdgeInsets.symmetric(horizontal: 2),
      activeColor: Style.secondaryColor,
      color: Colors.grey,
      activeSize: const Size(12, 5),
      activeShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }

  handleAlcoholAllowedChange(newValue) {
    setState(() {
      alcoholAllowed = !alcoholAllowed;
    });
  }

  handleOneNightOnlyChange(newValue) {
    setState(() {
      oneNightOnly = !oneNightOnly;
    });
  }

  handleBirthdayPartiesAllowedChange(newValue) {
    setState(() {
      birthdayPartiesAllowed = !birthdayPartiesAllowed;
    });
  }

  handleHasPoolChange(newValue) {
    setState(() {
      hasPool = !hasPool;
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

    if (images.length == 1 && !thumbnailSelected) {
      setState(() {
        images.first.isThumbnail = true;
      });
    }

    if (images.isNotEmpty && !thumbnailSelected) {
      Globals.notifier
          .setInfo("Thubmanil slika objekta je obavezna!", ToastType.Warning);
      return;
    }

    var payload = AccommodationUnitCreateDto(
        title: titleController.text,
        shortTitle: shortTitleController.text,
        price: num.parse(priceController.text),
        policy: PolicyCreateDto(
            alcoholAllowed: alcoholAllowed,
            capacity: num.parse(capacityController.text),
            oneNightOnly: oneNightOnly,
            birthdayPartiesAllowed: birthdayPartiesAllowed,
            hasPool: hasPool),
        categoryId: 1,
        files: images,
        townshipId: 4,
        latitude: latitude,
        longitude: longitude);

    try {
      var response = await provider.create(payload);

      if (mounted) {
        Navigator.pop(context, response);
      }
    } catch (ex) {
      print(ex);
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }
  }
}
