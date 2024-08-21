import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/widgets/home_custom/item_card.dart';
import 'package:flutter/material.dart';

class ItemCardList extends StatefulWidget {
  final List<AccommodationUnitGetDto> items;
  const ItemCardList({super.key, required this.items});

  @override
  State<ItemCardList> createState() => _ItemCardListState();
}

class _ItemCardListState extends State<ItemCardList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 350,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ItemCard(
                      item: widget.items[index],
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
