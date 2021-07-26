import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organd/components/coustom_bottom_nav_bar.dart';
import 'package:organd/components/default_button.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:organd/constants.dart';
import 'package:organd/enums.dart';
import 'package:organd/helper/MyHelper.dart';
import 'package:organd/helper/keyboard.dart';
import 'package:organd/models/appointment.dart';
import 'package:organd/models/donor.dart';
import 'package:organd/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationShow extends StatefulWidget {
  static String routeName = "/donation-show";
  String password;

  @override
  _DonationShow createState() => new _DonationShow();
}

class _DonationShow extends State<DonationShow> with MyHelper {
  Future<LinkedHashMap> getDonation;
  String url;
  String status;
  String password;
  int donor_id;
  int recipient_id;
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.utc(1999);

  @override
  void initState() {
    super.initState();
    url = MyConstants.ipAddress;

    getDonation = getDonationInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.08,
            left: SizeConfig.screenHeight * 0.02,
            right: SizeConfig.screenWidth * 0.05),
        child: SizedBox(
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Donation Info",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                ),
              ),

              FutureBuilder<Map>(
                future: getDonation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);


                    var data = snapshot.data['data'];
                    print( data.toString());
                    if(data.toString()=="[]"){
                      return Center(
                        child: Text("No Data"),
                      );
                    }

                    var donation = data['donation'];
                    var donor = data['donor'];
                    var recipient = data['recipient'];
                    var proccesedBy = data['proccessed_by'];
                    var donation_center = data['donation_center'];

                    if(donation['status']==0){
                      status="Donation Ongoing";

                    }
                    else if(donation['status']==1){
                      status="Your Donation is Done thank you for saving life";

                    }
                    else if(donation['status']==2){
                      status="Donation Process cancelled";

                    }
                    else if(donation['status']==3){
                      status="Your Donation is Done thank you for saving life";

                    }    else if(donation['status']==4){
                      status="Your Donation is Done thank you for saving life";

                    }

                    return Expanded(
                        child: ListView(children: [
                      Text(
                        status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                          SizedBox(height:  getProportionateScreenHeight(40),),
                          Text(
                        "Donor Info",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildListTile("assets/icons/User Icon.svg", "Full Name",
                          "${donor['firstName']} ${donor['middleName']} ${donor['lastName']}"),
                      buildListTile("assets/icons/User Icon.svg", "Gender",
                          "${donor['sex']}"),
                      buildListTile("assets/icons/User Icon.svg",
                          "Blood Type", "${donor['bloodType']}"),
                          SizedBox(height:  getProportionateScreenHeight(40),),
                          Text(
                        "Recipient Info",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildListTile("assets/icons/User Icon.svg", "Full Name",
                          "${recipient['firstName']} ${recipient['middleName']} ${recipient['lastName']}"),
                      buildListTile("assets/icons/User Icon.svg", "Gender",
                          "${recipient['sex']}"),
                      buildListTile("assets/icons/User Icon.svg",
                          "Blood Type", "${recipient['bloodType']}"),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Text(
                        "Doctor info",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildListTile("assets/icons/User Icon.svg", "Full Name",
                          "${proccesedBy['firstName']} ${proccesedBy['middleName']} ${proccesedBy['lastName']}"),
                      buildListTile("assets/icons/User Icon.svg", "Gender",
                          "${proccesedBy['sex']}"),
                      buildListTile("assets/icons/User Icon.svg", "Phone",
                          "${proccesedBy['phone']}"),
                      buildListTile("assets/icons/User Icon.svg", "Email",
                          "${proccesedBy['email']}"),
                      SizedBox(height: getProportionateScreenHeight(30)),


                          Text(
                        "Donation Center",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildListTile("assets/icons/User Icon.svg", "Name",
                          "${donation_center['name']}  "),
                      buildListTile("assets/icons/User Icon.svg", "Address",
                          "${donation_center['address']}"),

                      SizedBox(height: getProportionateScreenHeight(30)),
                    ]));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }

  Container buildListTile(String icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        dense: false,
        minVerticalPadding: 8,
        contentPadding: EdgeInsets.all(SizeConfig.screenHeight * 0.005),
        tileColor: Color(0xFFF5F6F9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: SvgPicture.asset(
          icon,
          color: kPrimaryColor,
          width: 28,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: kSecondaryColor),
        ),
        subtitle: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${subtitle != 'null' ? subtitle : "...."}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: kPrimaryColor),
            )),
      ),
    );
  }

  Future<LinkedHashMap> getDonationInfo() async {
    final prefs = await SharedPreferences.getInstance();

    donor_id = await prefs.getInt('donor_id');
    recipient_id = await prefs.getInt('recipient_id');

    var data = {
      'donor_id': donor_id,
      'recipient_id': recipient_id,
    };

    var client = http.Client();
    try {
      Future<http.Response> uriResponse =
          sendRequest(context, '/api/donation/show', data);
      return uriResponse.then((value) {
        return jsonDecode(value.body);
      });
    } finally {
      client.close();
    }
  }
}
