import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:flutter/material.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key});

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              image: const DecorationImage(
                  image: AssetImage("assets/images/apartment.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    "Villa Blagaj",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Icon(
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
                  Text("Mostar", style: CustomTheme.smallTextStyle)
                ],
              ),
              Text(
                "Lorem ipsum iafaskp",
                style: CustomTheme.smallTextStyle,
              ),
              Text(
                "380KM",
                style: CustomTheme.smallTextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
