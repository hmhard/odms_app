import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:organd/components/coustom_bottom_nav_bar.dart';
import 'package:organd/components/default_button.dart';
import 'package:organd/constants.dart';
import 'package:organd/enums.dart';
import 'package:organd/models/donation_center.dart';
import 'package:organd/models/recipient.dart';
import 'package:organd/screens/profile/components/profile_pic.dart';
import 'package:organd/screens/splash/components/splash_content.dart';
import 'package:organd/size_config.dart';

 

class DonationCenterShow extends StatefulWidget {
  static String routeName="/donation-center";
  String password;


  @override
  _DonationCenterShow createState() => new _DonationCenterShow();
}

class _DonationCenterShow extends State<DonationCenterShow> {
  Future<List<DonationCenter>> donationCenter;

  String password;
  _DonationCenterShow(){

  }
  @override
  void initState() {
    super.initState();
    donationCenter = fetchDonationCenter();
  }


  Future<List<DonationCenter>> fetchDonationCenter() async {


    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('http://10.140.10.68/per/organd_back/public/index.php/api/donation-center/'),
          headers: {
            'Access-Control-Allow-Origin': '*',
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, PATCH, DELETE",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
            "Content-Type": "application/json",
            "responseHeader": "Access-Control-Allow-Origin",

          },
          body: json.encode({"id":1})
      );

      print(uriResponse.statusCode);
      print(json.decode(uriResponse.body)['data']);
      if(uriResponse.statusCode==200){
        List data= json.decode(uriResponse.body)['data'];
        List<DonationCenter> r =new List<DonationCenter>();
        for(int i=0;i<data.length;i++){
          print(data.length);
          r.add(DonationCenter.fromJson(data[i]));
        }

        return r;
        //   Navigator.pushNamed(context, "donor-show");
      }else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {
      client.close();
    }

  }
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      // drawer: myDrawer(),
      body: Container(

        margin: EdgeInsets.only(top: SizeConfig.screenHeight* 0.02,left: SizeConfig.screenWidth* 0.05,right:  SizeConfig.screenWidth* 0.05 ),
        child: FutureBuilder<List<DonationCenter>>(
          future: donationCenter,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              var data = snapshot.data;

                return SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Donation Centers",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(36),

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: PageView.builder(
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                          itemCount: data.length,
                          itemBuilder: (context, index) => Column(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                data[index].name,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(36),
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                               data[index].description,
                                textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(16),


                                  )
                              ),
                              Spacer(flex: 1),
                              Text(
                                data[index].address,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Column(
                            children: <Widget>[
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  data.length,
                                      (index) => buildDot(index: index),
                                ),
                              ),
                              Spacer(flex: 1),
                              DefaultButton(
                                text: "Select",
                                press: () {

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
              );





            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
  Container buildListTile(String icon, String title, String subtitle) {
    return

      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          dense: false,
          minVerticalPadding: 10,

          contentPadding:    EdgeInsets.all(10),
          tileColor: Color(0xFFF5F6F9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          leading: SvgPicture.asset(
            icon,
            color: kPrimaryColor,
            width: 28,
          ) ,
          title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color:kSecondaryColor ),),
          subtitle: Align(
              alignment: Alignment.centerRight,
              child: Text("${subtitle!='null'?subtitle:"...."}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal, color: kPrimaryColor),)) ,
        ),
      );
  }


 







}