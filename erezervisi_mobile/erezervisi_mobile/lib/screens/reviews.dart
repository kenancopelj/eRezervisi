// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:erezervisi_mobile/widgets/reviews_custom/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 80,
                ),
                Text(
                  "Recenzije objekta",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "4.3",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: RatingBar.builder(
                  minRating: 1,
                  maxRating: 5,
                  itemCount: 5,
                  allowHalfRating: true,
                  initialRating: 4.3,
                  itemSize: 16,
                  itemBuilder: (context, _) => Icon(Icons.star),
                  onRatingUpdate: (rating) {}),
            ),
            SizedBox(
              height: 50,
            ),
            ReviewItem(),
            ReviewItem(),
            ReviewItem(),
            ReviewItem(),
            ReviewItem(),
            ReviewItem(),
            ReviewItem(),
            ReviewItem(),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
