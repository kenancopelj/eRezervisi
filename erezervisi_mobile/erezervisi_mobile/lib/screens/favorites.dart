import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/widgets/favorites/favorite_card.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Omiljeni",
                  style: CustomTheme.largeTextStyle,
                ),
                Spacer(),
                Icon(Icons.search)
              ],
            ),
            SizedBox(
              height: 50,
            ),
            FavoriteCard(),
            SizedBox(
              height: 15,
            ),
            FavoriteCard(),
            SizedBox(
              height: 15,
            ),
            FavoriteCard(),
            SizedBox(
              height: 15,
            ),
            FavoriteCard(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
