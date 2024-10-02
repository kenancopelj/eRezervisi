import 'package:erezervisi_mobile/models/responses/review/get_reviews_response.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyChatState();
}

class _MyChatState extends State<MyReviews> {
  late UserProvider userProvider;

  var reviews = GetReviewsResponse(reviews: []);

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();

    loadReviews();
  }

  Future loadReviews() async {
    var response = await userProvider.getMyReviews();

    if (mounted) {
      setState(() {
        reviews = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Scaffold(
          body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final review = reviews.reviews[index];
          return ExpansionTile(
            minTileHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(review.title),
                RatingBar(
                  minRating: review.rating.toDouble(),
                  ignoreGestures: true,
                  glowColor: Colors.yellow,
                  maxRating: review.rating.toDouble(),
                  itemCount: review.rating.toInt(),
                  allowHalfRating: false,
                  initialRating: review.rating.toDouble(),
                  itemSize: 16,
                  onRatingUpdate: (rating) {},
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star),
                      half: const Icon(Icons.star),
                      empty: const Icon(Icons.star)),
                ),
              ],
            ),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Align(
                    alignment: Alignment.centerLeft, child: Text(review.note)),
              )
            ],
          );
        },
        itemCount: reviews.reviews.length,
      )),
    );
  }
}
