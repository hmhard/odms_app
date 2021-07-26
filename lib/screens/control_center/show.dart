import 'package:flutter/material.dart';

import 'package:organd/components/coustom_bottom_nav_bar.dart';
import 'package:organd/components/default_button.dart';
import 'package:organd/constants.dart';

import 'package:organd/enums.dart';
import 'package:organd/screens/appointment/appoint_donor.dart';
import 'package:organd/screens/donation/show.dart';
import 'package:organd/screens/donation_center/show.dart';
import 'package:organd/screens/profile/profile_screen.dart';

import 'package:organd/size_config.dart';

class ControlCenter extends StatefulWidget {
  static String routeName = "/control";
  String password;

  @override
  _ControlCenter createState() => new _ControlCenter();
}

class _ControlCenter extends State<ControlCenter> {
  String password;

  _ControlCenter() {}

  @override
  void initState() {
    super.initState();
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.02,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome Friend",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(26),
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Home Page",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(50)),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: <Widget>[
                        Spacer(flex: 1),
                        MyButton(
                          text: "View Donation Info",
                          color: Colors.green,
                          press: () {
                            Navigator.pushNamed(
                                context, DonationShow.routeName);
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        MyButton(
                          text: "View Appointment",
                          color: Colors.blue,
                          press: () {
                            Navigator.pushNamed(
                                context, AppointmentShow.routeName);
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        MyButton(
                          text: "View Donation Centers",
                          color: Colors.teal,
                          press: () {
                            Navigator.pushNamed(
                                context, DonationCenterShow.routeName);
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        MyButton(
                          text: "View My Profile",
                          color: Colors.cyan,
                          press: () {
                            Navigator.pushNamed(
                                context, ProfileScreen.routeName);
                          },
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // By default, show a loading spinner.
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key key,
    this.text,
    this.color,
    this.press,
  }) : super(key: key);
  final String text;
  final Color color;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(106),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color,
        onPressed: press,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
