// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:io';

import 'package:erezervisi_mobile/enums/accommodation_unit_filter.dart';
import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/screens/accommodation_units.dart';
import 'package:erezervisi_mobile/screens/chat.dart';
import 'package:erezervisi_mobile/screens/my_reviews.dart';
import 'package:erezervisi_mobile/screens/reservations.dart';
import 'package:erezervisi_mobile/screens/settings.dart';
import 'package:erezervisi_mobile/shared/globals.dart';
import 'package:erezervisi_mobile/shared/navigator/navigate.dart';
import 'package:erezervisi_mobile/shared/navigator/route_list.dart';
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
                Globals.image != null
                    ? Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: NetworkImage(
                                  Globals.imageBasePath + Globals.image!),
                              fit: BoxFit.contain),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          Globals.loggedUser!.initials,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
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
                  onTap: () {
                    Navigate.next(
                        context,
                        AppRoutes.accommodationUnits.routeName,
                        AccommodationUnits(
                            filter: AccommodationUnitFilter.Popular),
                        true);
                  },
                  title: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child:
                        Text('Populano', style: CustomTheme.menuItemTextStyle),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigate.next(
                        context,
                        AppRoutes.accommodationUnits.routeName,
                        AccommodationUnits(
                            filter: AccommodationUnitFilter.Latest),
                        true);
                  },
                  title: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text('Nove ponude',
                        style: CustomTheme.menuItemTextStyle),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigate.next(
                        context,
                        AppRoutes.accommodationUnits.routeName,
                        AccommodationUnits(
                            filter: AccommodationUnitFilter.Recommended),
                        true);
                  },
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
                Navigate.next(context, AppRoutes.reservations.routeName,
                    MyReservations(), true);
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
                Navigate.next(
                    context, AppRoutes.chat.routeName, MyChat(), true);
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
                Navigate.next(
                    context, AppRoutes.myReviews.routeName, MyReviews(), true);
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
          Spacer(), // Spacer to push the last two options to the bottom
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5),
            child: ListTile(
              onTap: () {
                Navigate.next(context, AppRoutes.settings.routeName,
                    SettingsScreen(), true);
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
