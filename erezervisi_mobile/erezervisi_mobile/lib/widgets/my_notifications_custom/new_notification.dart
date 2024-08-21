import 'package:flutter/material.dart';

class NewNotification extends StatefulWidget {
  const NewNotification({super.key});

  @override
  State<NewNotification> createState() => _NewNotificationState();
}

class _NewNotificationState extends State<NewNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/images/user.png')),
                borderRadius: BorderRadius.circular(30)),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width - 120,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dostupan objekat",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Objekat koji ste dodali u Omiljene je dostupan za rezervaciju",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
