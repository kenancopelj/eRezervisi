import 'package:erezervisi_mobile/models/requests/base/base_get_all_request.dart';
import 'package:erezervisi_mobile/models/responses/search/search_response.dart';
import 'package:erezervisi_mobile/providers/search_provider.dart';
import 'package:erezervisi_mobile/shared/components/form/button.dart';
import 'package:erezervisi_mobile/shared/components/form/input.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/style.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Debouncer _debouncer = Debouncer();

  var searchController = TextEditingController();

  bool searchInProgress = false;

  var request = BaseGetAllRequest.def();

  var items = SearchResponse(accommodationUnits: [], users: []);

  late SearchProvider searchProvider;

  @override
  void initState() {
    super.initState();

    searchProvider = context.read<SearchProvider>();
  }

  Future loadData() async {
    var response = await searchProvider.get(request);

    setState(() {
      items = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return MasterWidget(
        child: Column(
      children: [
        SizedBox(
          height: h - 400,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchInProgress = true;
                          });
                          _debouncer.debounce(
                              duration: Globals.debounceTimeout,
                              onDebounce: () {
                                setState(() {
                                  request.searchTerm = value;
                                  searchInProgress = false;
                                });
                                loadData();
                              });
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.text = "";
                                });
                              },
                              icon: const Icon(Icons.clear),
                            ),
                            constraints: BoxConstraints(maxWidth: w - 70),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            hintText: "Pretražite osobe, objekte...",
                            hintStyle: TextStyle(color: Style.borderColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Style.borderColor, width: 0.5))),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (!searchInProgress)
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(Icons.search),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Prethodne pretrage",
                          style: TextStyle(
                              color: Style.primaryColor100,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: items.accommodationUnits.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                items.accommodationUnits[index].title,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.search),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Pretražite kategorije",
                        style: TextStyle(
                            color: Style.primaryColor100,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
