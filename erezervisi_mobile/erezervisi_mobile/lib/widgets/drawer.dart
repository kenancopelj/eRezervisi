// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/screens/chat.dart';
import 'package:erezervisi_mobile/screens/my_reviews.dart';
import 'package:erezervisi_mobile/screens/reservations.dart';
import 'package:erezervisi_mobile/screens/settings.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:flutter/material.dart';

class eRezervisiDrawer extends StatefulWidget {
  const eRezervisiDrawer({super.key});

  @override
  State<eRezervisiDrawer> createState() => _eRezervisiDrawerState();
}

class _eRezervisiDrawerState extends State<eRezervisiDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/user.png'))),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${Globals.loggedUser!.firstName} ${Globals.loggedUser!.lastName}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Spacer(),
                
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ExpansionTile(
              collapsedIconColor: Colors.white,
              initiallyExpanded: false,
              leading: Icon(
                Icons.apartment_sharp,
                color: Colors.white,
              ),
              title: Text(
                'Objekti',
                style: CustomTheme.menuItemTextStyle,
              ),
              children: [
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child:
                        Text('Populano', style: CustomTheme.menuItemTextStyle),
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text('Nove ponude',
                        style: CustomTheme.menuItemTextStyle),
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text('Preporučeno',
                        style: CustomTheme.menuItemTextStyle),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ListTile(
              onTap: () {
                Navigate.next(context, MyReservations(), true);
              },
              leading: Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
              ),
              title: Text('Rezervacije', style: CustomTheme.menuItemTextStyle),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyChat()));
              },
              leading: Icon(
                Icons.chat_bubble_outline_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Chat',
                style: CustomTheme.menuItemTextStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyReviews()));
              },
              leading: Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Moje recenzije',
                style: CustomTheme.menuItemTextStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyChat()));
              },
              leading: Icon(
                Icons.history,
                color: Colors.white,
              ),
              title: Text(
                'Historija rezervacija',
                style: CustomTheme.menuItemTextStyle,
              ),
            ),
          ),
          Spacer(), // Spacer to push the last two options to the bottom
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ListTile(
              onTap: () {
                Navigate.next(context, SettingsScreen(), true);
              },
              leading: Icon(
                Icons.settings_outlined,
                color: Colors.white,
              ),
              title: Text('Postavke', style: CustomTheme.menuItemTextStyle),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, bottom: 16),
            child: ListTile(
              onTap: () {
                Globals.notifier.logoutUser();
              },
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              title: Text('Odjavi se', style: CustomTheme.menuItemTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
