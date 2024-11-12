import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/screens/accommodation_unit_details.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final AccommodationUnitGetDto item;
  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigate.next(context, AppRoutes.accommodationUnitDetails.routeName,
            ObjectDetails(accommodationUnitId: widget.item.id), true);
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 2.0,
        child: Container(
          width: 250,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: SizedBox(
                        height: 168,
                        width: 224,
                        child: Image.network(Globals.imageBasePath +
                            widget.item.thumbnailImage)),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Text(
                        widget.item.title,
                        style: CustomTheme.mediumTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(Icons.location_on),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.item.township.title,
                      style: const TextStyle(color: Colors.black))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.item.note ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${widget.item.price}KM",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 15,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
