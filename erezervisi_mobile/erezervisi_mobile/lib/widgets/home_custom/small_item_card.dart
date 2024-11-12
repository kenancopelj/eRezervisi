import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/screens/accommodation_unit_details.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
import 'package:flutter/material.dart';

class SmallItemCard extends StatefulWidget {
  final AccommodationUnitGetDto item;
  const SmallItemCard({super.key, required this.item});

  @override
  State<SmallItemCard> createState() => _SmallItemCardState();
}

class _SmallItemCardState extends State<SmallItemCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigate.next(
          context,
          AppRoutes.accommodationUnitDetails.routeName,
          ObjectDetails(accommodationUnitId: widget.item.id),
          true,
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 2.0,
        child: Container(
          width: screenWidth * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5)),
                child: Image.network(
                  Globals.imageBasePath + widget.item.thumbnailImage,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  widget.item.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.item.township.title,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.item.note != null && widget.item.note!.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    widget.item.note!,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      "${widget.item.price} KM",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
