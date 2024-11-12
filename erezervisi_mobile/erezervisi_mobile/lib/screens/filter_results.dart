import 'package:erezervisi_mobile/models/dropdown_item.dart';
import 'package:erezervisi_mobile/models/requests/canton/get_all_cantons_request.dart';
import 'package:erezervisi_mobile/models/requests/category/get_all_categories_request.dart';
import 'package:erezervisi_mobile/models/requests/townshp/get_all_townships_request.dart';
import 'package:erezervisi_mobile/providers/canton_provider.dart';
import 'package:erezervisi_mobile/providers/category_provider.dart';
import 'package:erezervisi_mobile/providers/township_provider.dart';
import 'package:erezervisi_mobile/screens/search_results.dart';
import 'package:erezervisi_mobile/shared/components/form/dropdown.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FilterResults extends StatefulWidget {
  final String searchTerm;
  num? categoryId;
  num? townshipId;
  num? cantonId;
  bool? oneNightOnly;
  bool? alcoholAllowed;
  num? capacity;
  bool? withPool;
  bool? birthdayPartiesAllowed;
  FilterResults(
      {required this.searchTerm,
      this.categoryId,
      this.townshipId,
      this.cantonId,
      this.oneNightOnly,
      this.alcoholAllowed,
      this.capacity,
      this.withPool,
      this.birthdayPartiesAllowed,
      super.key});

  @override
  State<FilterResults> createState() => _FilterResultsState();
}

class _FilterResultsState extends State<FilterResults> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController cantonController = TextEditingController();
  final TextEditingController townshipController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  num? categoryId;
  num? cantonId;
  num? townshipId;

  String? categoryTitle;
  String? cantonTitle;
  String? townshipTitle;

  bool alcoholAllowed = false;
  bool oneNightOnly = false;
  bool withPool = false;
  bool birthdayPartiesAllowed = false;

  List<DropdownItem> categories = [];
  List<DropdownItem> cantons = [];
  List<DropdownItem> townships = [];

  var categoriesRequest = GetAllCategoriesRequest(searchTerm: '');
  var cantonsRequest = GetAllCantonsRequest(searchTerm: '');
  var townshipsRequest = GetAllTownshipsRequest(searchTerm: '');

  late CategoryProvider categoryProvider;
  late CantonProvider cantonProvider;
  late TownshipProvider townshipProvider;

  @override
  void initState() {
    super.initState();

    categoryProvider = context.read<CategoryProvider>();
    cantonProvider = context.read<CantonProvider>();
    townshipProvider = context.read<TownshipProvider>();

    townshipsRequest.cantonId = widget.cantonId;

    loadCantons();
    loadTownships();
    loadCategories();

    categoryId = widget.categoryId;

    if (categoryId != null) {
      categoryTitle =
          categories.where((item) => item.key == categoryId).firstOrNull?.value;
    } else {
      categoryTitle = null;
    }

    cantonId = widget.cantonId;

    if (cantonId != null) {
      cantonTitle =
          cantons.where((item) => item.key == cantonId).firstOrNull?.value;
    } else {
      cantonTitle = null;
    }

    townshipId = widget.townshipId;

    if (townshipId != null) {
      townshipTitle =
          townships.where((item) => item.key == townshipId).firstOrNull?.value;
    } else {
      townshipTitle = null;
    }

    alcoholAllowed = widget.alcoholAllowed ?? false;
    oneNightOnly = widget.oneNightOnly ?? false;
    withPool = widget.withPool ?? false;
    birthdayPartiesAllowed = widget.birthdayPartiesAllowed ?? false;
    capacityController.text =
        widget.capacity != null ? widget.capacity.toString() : "";
  }

  Future loadCategories() async {
    var response = await categoryProvider.getAll(categoriesRequest);

    setState(() {
      categories = response.categories
          .map((item) => DropdownItem(key: item.id, value: item.title))
          .toList();
    });
  }

  Future loadCantons() async {
    var response = await cantonProvider.getAll(cantonsRequest);

    setState(() {
      cantons = response.cantons
          .map((item) => DropdownItem(key: item.id, value: item.title))
          .toList();
    });
  }

  Future loadTownships() async {
    var response = await townshipProvider.getAll(townshipsRequest);

    setState(() {
      townships = response.townships
          .map((item) => DropdownItem(key: item.id, value: item.title))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 16,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            categoryId = null;
                            cantonId = null;
                            townshipId = null;
                            townshipsRequest.cantonId = null;
                            alcoholAllowed = false;
                            oneNightOnly = false;
                            withPool = false;
                            birthdayPartiesAllowed = false;
                            cantonTitle = null;
                            townshipTitle = null;
                            categoryTitle = null;
                          });

                          loadCantons();
                          loadTownships();
                        },
                        child: const Text(
                          "Očisti",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (cantonId != null) {
                            setState(() {
                              cantonTitle = cantons
                                  .where((item) => item.key == cantonId)
                                  .firstOrNull
                                  ?.value;
                            });
                          } else {
                            setState(() {
                              cantonTitle = null;
                            });
                          }

                          setState(() {
                            townshipId = townshipId ?? widget.townshipId;
                          });

                          if (townshipId != null) {
                            setState(() {
                              townshipTitle = townships
                                  .where((item) => item.key == townshipId)
                                  .firstOrNull
                                  ?.value;
                            });
                          } else {
                            setState(() {
                              townshipTitle = null;
                            });
                          }

                          Navigate.next(
                              context,
                              AppRoutes.searchResults.routeName,
                              SearchResults(
                                searchTerm: widget.searchTerm,
                                categoryId: categoryId,
                                categoryTitle: categoryTitle,
                                cantonId: cantonId,
                                townshipId: townshipId,
                                alcoholAllowed: alcoholAllowed,
                                oneNightOnly: oneNightOnly,
                                withPool: withPool,
                                capacity: capacityController.text.isEmpty
                                    ? null
                                    : int.parse(capacityController.text),
                                birthdayPartiesAllowed: birthdayPartiesAllowed,
                                cantonTitle: cantonTitle,
                                townshipTitle: townshipTitle,
                              ));
                        },
                        child: const Text(
                          "Primjeni",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Dropdown(
                withSearch: true,
                label: 'Kategorija',
                outline: true,
                padding: 10,
                value: categoryId,
                placeholder: 'Odaberite kategoriju',
                items: categories,
                controller: categoryController,
                onChanged: (value) {
                  setState(() {
                    categoryId = value;

                    categoryTitle = categories
                        .where((item) => item.key == value)
                        .first
                        .value;
                  });

                  loadTownships();
                }),
            Dropdown(
                withSearch: true,
                label: 'Kanton',
                outline: true,
                padding: 10,
                value: cantonId,
                placeholder: 'Odaberite kanton',
                items: cantons,
                controller: cantonController,
                onChanged: (value) {
                  setState(() {
                    cantonId = value;
                    townshipsRequest.cantonId = value;

                    cantonTitle =
                        cantons.where((item) => item.key == value).first.value;
                  });

                  loadTownships();
                }),
            Dropdown(
                withSearch: true,
                label: 'Opština/Grad',
                outline: true,
                padding: 10,
                value: townshipId,
                placeholder: 'Odaberite grad',
                items: townships,
                controller: townshipController,
                onChanged: (value) {
                  setState(() {
                    townshipId = value;

                    townshipTitle = townships
                        .where((item) => item.key == value)
                        .first
                        .value;
                  });
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kapacitet (minimalno)",
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextField(
                    controller: capacityController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dozvoljen alkohol"),
                  Checkbox(
                    value: alcoholAllowed,
                    onChanged: (bool? value) {
                      setState(() {
                        alcoholAllowed = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sa bazenom"),
                  Checkbox(
                    value: withPool,
                    onChanged: (bool? value) {
                      setState(() {
                        withPool = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dozvoljene rođendanske proslave"),
                  Checkbox(
                    value: birthdayPartiesAllowed,
                    onChanged: (bool? value) {
                      setState(() {
                        birthdayPartiesAllowed = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Samo jedno noćenje"),
                  Checkbox(
                    value: oneNightOnly,
                    onChanged: (bool? value) {
                      setState(() {
                        oneNightOnly = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
