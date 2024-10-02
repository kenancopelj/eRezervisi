import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/favorites/get_favorites_request.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/favorites/favorite_get_dto.dart';
import 'package:erezervisi_mobile/providers/favorites_provider.dart';
import 'package:erezervisi_mobile/widgets/favorites/favorite_card.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  late FavoritesProvider favoritesProvider;

  var accommodationUnits = PagedResponse<FavoriteGetDto>.empty();
  var request = GetFavoritesRequest.def();

  @override
  void initState() {
    super.initState();

    favoritesProvider = context.read<FavoritesProvider>();

    loadFavorites();
  }

  Future loadFavorites() async {
    var response = await favoritesProvider.getPaged(request);

    setState(() {
      accommodationUnits = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Omiljeni",
                  style: CustomTheme.largeTextStyle,
                ),
                const Spacer(),
                const Icon(Icons.search)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: accommodationUnits.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FavoriteCard(
                      accommodationUnit: accommodationUnits
                          .items[index].accommodationUnitGetDto,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
