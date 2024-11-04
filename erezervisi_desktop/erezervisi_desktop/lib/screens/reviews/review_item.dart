import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItem extends StatelessWidget {
  final ReviewGetDto item;
  const ReviewItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/user.png"))),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                item.reviewer,
                style: TextStyle(color: Colors.grey[700]),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              RatingBar.builder(
                  minRating: 1,
                  maxRating: 5,
                  itemCount: 5,
                  allowHalfRating: true,
                  initialRating: 4.3,
                  itemSize: 16,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: CustomTheme.bluePrimaryColor,
                      ),
                  onRatingUpdate: (rating) {}),
              const SizedBox(
                width: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  "13.08.2023",
                  style: TextStyle(
                      color: Color.fromARGB(255, 90, 90, 90), fontSize: 12),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Row(
              children: [
                Icon(
                  Icons.message_outlined,
                  color: Colors.black,
                  size: 14,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Sve pohvale",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
