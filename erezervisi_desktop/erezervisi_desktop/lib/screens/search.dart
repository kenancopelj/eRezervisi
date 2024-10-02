import 'package:erezervisi_desktop/shared/components/form/button.dart';
import 'package:erezervisi_desktop/shared/components/form/input.dart';
import 'package:erezervisi_desktop/shared/style.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> searches = ["Mostar", "Villa Blagaj", "vikendica"];

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return MasterWidget(
      child: Scaffold(
          floatingActionButton: Button(
            onClick: () {},
            label: "Prikaži sve rezultate",
          ),
          body: SizedBox(
            width: w,
            height: h,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios, size: 16,)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
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
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                            itemCount: searches.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  searches[index],
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
          )),
    );
  }
}
