import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/screens/accommodation_unit_details.dart';
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ObjectDetails(
                      accommodationUnitId: widget.item.id,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          elevation: 2.0,
          child: Container(
            width: 250,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Container(
                        height: 168,
                        width: 224,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/apartment.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.item.title,
                      style: CustomTheme.largeTextStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.item.township.title,
                        style: TextStyle(color: Colors.black))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.item.note ?? "",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "${widget.item.price}KM",
                      style: TextStyle(color: Colors.black),
                    ),
                    Spacer(),
                    Icon(Icons.favorite_outline),
                    SizedBox(
                      width: 15,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
