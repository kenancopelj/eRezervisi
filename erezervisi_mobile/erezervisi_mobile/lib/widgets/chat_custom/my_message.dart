import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatefulWidget {
  const MyMessage({super.key});

  @override
  State<MyMessage> createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 75,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: CustomTheme.bluePrimaryColor,
                borderRadius: BorderRadius.circular(30)),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width - 120,
            child: Text(
              "Pozdrav, da li je objekat slobodan u perioud od 10.10 do 12.10? Hvala",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
