import 'package:erezervisi_desktop/helpers/helpers.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItem extends StatefulWidget {
  final ReviewGetDto review;
  const ReviewItem({required this.review, super.key});

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

enum TimeAgoType { Minutes, Hours, Days }

class _ReviewItemState extends State<ReviewItem> {
  TimeAgoType timeAgoType = TimeAgoType.Minutes;

  num timeAgo() {
    if (widget.review.minutesAgo > 59) {
      if (widget.review.hoursAgo > 24) {
        setState(() {
          timeAgoType = TimeAgoType.Days;
        });
        return widget.review.daysAgo;
      } else {
        setState(() {
          timeAgoType = TimeAgoType.Hours;
        });
        return widget.review.hoursAgo;
      }
    } else {
      setState(() {
        timeAgoType = TimeAgoType.Minutes;
      });
      return widget.review.minutesAgo;
    }
  }

  String timeAgoLabel() {
    switch (timeAgoType) {
      case TimeAgoType.Days:
        return timeAgo() == 1 ? "dan" : "dana";
      case TimeAgoType.Hours:
        return timeAgo() == 1 ? "sat" : "sata";
      default:
        return "minuta";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              if (widget.review.reviewerImage != null)
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(Globals.imageBasePath +
                              widget.review.reviewerImage!))),
                ),
              if (widget.review.reviewerImage == null)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    Helpers.getInitials(widget.review.reviewer),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.review.reviewer,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  RatingBar.builder(
                      minRating: 1,
                      maxRating: 5,
                      itemCount: 5,
                      initialRating: widget.review.rating.toDouble(),
                      itemSize: 16,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                      onRatingUpdate: (rating) {}),
                ],
              ),
              const Spacer(),
              Text(
                "prije ${timeAgo()} ${timeAgoLabel()}",
                style: const TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90), fontSize: 12),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.review.note ?? "",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97), fontSize: 12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
