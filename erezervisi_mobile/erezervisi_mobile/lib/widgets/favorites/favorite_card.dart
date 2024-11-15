import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/screens/accommodation_unit_details.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatefulWidget {
  final AccommodationUnitGetDto accommodationUnit;

  const FavoriteCard({super.key, required this.accommodationUnit});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigate.next(context, AppRoutes.accommodationUnitDetails.routeName, ObjectDetails(accommodationUnitId: widget.accommodationUnit.id), true);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
            color: Color.fromARGB(252, 240, 240, 240),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(Globals.imageBasePath + widget.accommodationUnit.thumbnailImage)
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.accommodationUnit.title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.accommodationUnit.township.title,
                        style: CustomTheme.smallTextStyle)
                  ],
                ),
                Text(
                  widget.accommodationUnit.note ?? '',
                  style: CustomTheme.smallTextStyle,
                ),
                Text(
                  "${widget.accommodationUnit.price}KM",
                  style: CustomTheme.smallTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
