import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItem extends StatefulWidget {
  const ReviewItem({super.key});

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Column(
        children: [
          Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: AssetImage("assets/images/user.png")
                    )
                  ),
                ),
                Text("Kenan Čopelj", style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left:30, top:10),
              child: Row(
                children: [
                  RatingBar.builder(
                  minRating: 1,
                  maxRating: 5,
                  itemCount: 5,
                  allowHalfRating: true,
                  initialRating: 4.3,
                  itemSize: 16,
                  itemBuilder: (context, _) => Icon(Icons.star) , 
                  onRatingUpdate: (rating) {
                  }),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.only(top:4.0),
                    child: Text("13.08.2023", style: TextStyle(
                      color: const Color.fromARGB(255, 90, 90, 90),
                      fontSize: 12
                    ),),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left:30,top:10),
              child: Row(
                children: [
                  Icon(Icons.message_outlined, color: Colors.black,size: 14,),
                  SizedBox(width: 10,),
                  Text("Sve pohvale",style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),),
                ],
              ),
            )
        ],
      ),
    );
  }
}
