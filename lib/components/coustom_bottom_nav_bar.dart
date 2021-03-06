import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organd/home.dart' as Home;
import 'package:organd/main.dart';
import 'package:organd/screens/control_center/show.dart';
import 'package:organd/screens/donation_center/show.dart';
import 'package:organd/screens/profile/profile_screen.dart';
import 'package:organd/screens/recipient/show.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: ()   => Navigator.popAndPushNamed(context, ControlCenter.routeName),

              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
                onPressed: () async{
                   final  prefs = await SharedPreferences.getInstance();
        int donor_id= prefs.getInt('donor_id');
                if(donor_id!=null){

        Navigator.popAndPushNamed(context, "/donor-show");
  } else{

    Navigator.popAndPushNamed(context, "/recipient-show");
    }

                }



              ),
              IconButton(
                icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
                onPressed: () =>  Navigator.popAndPushNamed(context, DonationCenterShow.routeName),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                     Navigator.popAndPushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
