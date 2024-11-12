import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:erezervisi_mobile/enums/toast_type.dart';
import 'package:erezervisi_mobile/models/requests/image/image_create_dto.dart';
import 'package:erezervisi_mobile/models/requests/user/user_update_dto.dart';
import 'package:erezervisi_mobile/models/responses/user/user_get_dto.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/shared/components/form/button.dart';
import 'package:erezervisi_mobile/shared/components/form/input.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/shared/validators/auth/register.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late UserProvider userProvider;

  UserGetDto? user;

  var validator = RegisterValidator();

  ImageCreateDto? profileImage;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();

    loadProfile();
  }

  Future loadProfile() async {
    var response = await userProvider.getById(Globals.loggedUser!.userId);

    setState(() {
      user = response;
      if (user != null) {
        firstNameController.text = user!.firstName;
        lastNameController.text = user!.lastName;
        phoneController.text = user!.phone;
        addressController.text = user!.address;
        emailController.text = user!.email;
        usernameController.text = user!.username;

        if (user!.image != null) {
          profileImage =
              ImageCreateDto(imageFileName: user!.image, isThumbnail: false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return MasterWidget(
      child: Scaffold(
          body: Form(
        key: formKey,
        child: SizedBox(
          width: w,
          height: h,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text(
                      "Uredi profil",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        InkWell(
                            onTap: () {
                              // if (profileImage != null) {
                              //   showDialog(
                              //     barrierDismissible: false,
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return PreviewImage(
                              //         image: profileImage!.image!,
                              //       );
                              //     },
                              //   );
                              // }
                            },
                            child: profileImage != null &&
                                    profileImage!.imageBase64 == null &&
                                    user!.image != null
                                ? Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              Globals.imageBasePath +
                                                  user!.image!),
                                          fit: BoxFit.contain),
                                    ),
                                  )
                                : profileImage != null
                                    ? Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  profileImage!.image!.path)),
                                              fit: BoxFit.contain),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          Globals.loggedUser!.initials,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                        Positioned(
                          right: 15,
                          bottom: 15,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Style.secondaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8.0)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 150,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Stack(
                                        children: <Widget>[
                                          Column(
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(Style
                                                          .inputBackgroundColor),
                                                  elevation:
                                                      WidgetStateProperty.all(
                                                          0),
                                                  padding:
                                                      WidgetStateProperty.all(
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 12.0,
                                                              horizontal:
                                                                  16.0)),
                                                ),
                                                onPressed: () async {
                                                  final ImagePicker picker =
                                                      ImagePicker();
                                                  final XFile? image =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .camera,
                                                          imageQuality: Globals
                                                              .imageQuality,
                                                          maxHeight: Globals
                                                              .imageMaxHeight,
                                                          maxWidth: Globals
                                                              .imageMaxWidth);
                                                  if (image != null &&
                                                      mounted) {
                                                    var bytes = await image
                                                        .readAsBytes();
                                                    var base64image =
                                                        base64Encode(bytes);

                                                    setState(() {
                                                      profileImage =
                                                          ImageCreateDto(
                                                              imageBase64:
                                                                  base64image,
                                                              imageFileName:
                                                                  image.name,
                                                              image: image,
                                                              isThumbnail:
                                                                  false);
                                                    });

                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: Style
                                                              .primaryColor100,
                                                        )),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                        child: Text('Kamera',
                                                            style: TextStyle(
                                                              color: Style
                                                                  .primaryColor100,
                                                            ))),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStateProperty.all(Style
                                                          .inputBackgroundColor),
                                                  elevation:
                                                      WidgetStateProperty.all(
                                                          0),
                                                  padding:
                                                      WidgetStateProperty.all(
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 12.0,
                                                              horizontal:
                                                                  16.0)),
                                                ),
                                                onPressed: () async {
                                                  final ImagePicker picker =
                                                      ImagePicker();
                                                  final XFile? image =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery,
                                                          imageQuality: Globals
                                                              .imageQuality,
                                                          maxHeight: Globals
                                                              .imageMaxHeight,
                                                          maxWidth: Globals
                                                              .imageMaxWidth);
                                                  if (image != null &&
                                                      mounted) {
                                                    var bytes = await image
                                                        .readAsBytes();
                                                    var base64image =
                                                        base64Encode(bytes);

                                                    setState(() {
                                                      profileImage =
                                                          ImageCreateDto(
                                                              imageBase64:
                                                                  base64image,
                                                              imageFileName:
                                                                  image.name,
                                                              image: image,
                                                              isThumbnail:
                                                                  false);
                                                    });

                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child: Icon(
                                                          Icons.image_outlined,
                                                          color: Style
                                                              .primaryColor100,
                                                        )),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                        child: Text('Galerija',
                                                            style: TextStyle(
                                                              color: Style
                                                                  .primaryColor100,
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
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                }),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Input(
                    controller: firstNameController,
                    validator: validator.required,
                    label: "Ime",
                    hintText: "Unesite Vaše ime",
                  ),
                  Input(
                    controller: lastNameController,
                    validator: validator.required,
                    label: "Prezime",
                    hintText: "Unesite Vaše prezime",
                  ),
                  Input(
                    controller: phoneController,
                    validator: validator.required,
                    label: "Broj telefona",
                    hintText: "e.g. +387616161",
                  ),
                  Input(
                    controller: addressController,
                    validator: validator.required,
                    label: "Adresa",
                    hintText: "e.g. Ulica 13, Mostar",
                  ),
                  Input(
                    controller: emailController,
                    validator: validator.required,
                    label: "Email",
                    hintText: "e.g. name@example.com",
                  ),
                  Input(
                    controller: usernameController,
                    validator: validator.required,
                    label: "Korisničko ime",
                    hintText: "Unesite Vaše korisničko ime",
                  ),
                  // Input(
                  //   controller: passwordController,
                  //   validator: validator.required,
                  //   label: "Lozinka",
                  //   hintText: "Unesite Vašu lozinku",
                  // ),
                  // Input(
                  //   controller: passwordController,
                  //   validator: validator.required,
                  //   label: "Ponovljena lozinka",
                  //   hintText: "Potvrdite Vašu lozinku",
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    onClick: handleSubmit,
                    label: "SPREMI",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Future handleSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var payload = UserUpdateDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        address: addressController.text,
        email: emailController.text,
        username: usernameController.text,
        imageBase64: profileImage?.imageBase64,
        imageFileName: profileImage?.imageFileName,
        newPassword: null);

    UserGetDto? response;

    try {
      response = await userProvider.update(Globals.loggedUser!.userId, payload);

      Globals.image = response!.image;

      Globals.notifier.setInfo('Uspješno ažurirano', ToastType.Success);

      profileImage = null;
      loadProfile();
    } catch (ex) {
      if (ex is DioException) {
        var error = ex.response?.data["Error"];
        Globals.notifier.setInfo(error, ToastType.Error);
      }
    }
  }
}
