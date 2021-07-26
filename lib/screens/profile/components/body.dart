import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organd/screens/appointment/appoint_donor.dart';
import 'package:organd/screens/donation/show.dart';
import 'package:organd/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Appointments",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.popAndPushNamed(context, AppointmentShow.routeName);
            },
          ),
          ProfileMenu(
            text: "Donation",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.popAndPushNamed(context, DonationShow.routeName);

            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Alert"),
                    content: Text(
                        "Would you like to logout?"),
                    actions: [
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text("Continue"),
                        onPressed: ()async {
                          final  prefs = await SharedPreferences.getInstance();
                        prefs.remove('donor_id');
                        prefs.remove('recipient_id');
                        Navigator.popAndPushNamed(context, Login.routeName);
                        //SystemNavigator.pop();
                        }
                        ), //,
                    ],
                  );;
                },
              );
              // show the dialog

            }


          ),
        ],
      ),
    );
  }
}
