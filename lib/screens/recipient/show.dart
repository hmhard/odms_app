import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:organd/components/coustom_bottom_nav_bar.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:organd/constants.dart';
import 'package:organd/enums.dart';
import 'package:organd/models/recipient.dart';
import 'package:organd/screens/profile/components/profile_pic.dart';
import 'package:organd/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RecipientShow extends StatefulWidget {
  static String routeName="/recipient-show";
  String password;


  @override
  _RecipientShow createState() => new _RecipientShow();
}

class _RecipientShow extends State<RecipientShow> {
    Future<Recipient> futureAlbum;

  String password;
  _RecipientShow(){

  }
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }


  Future<Recipient> fetchAlbum() async {


    final prefs = await SharedPreferences.getInstance();
    int recipient_id= prefs.getInt('recipient_id');

    var client = http.Client();
    try {
      String url= MyConstants.ipAddress;
      var uriResponse = await client.post(Uri.parse('${url}/api/recipient/show'),
          headers: {
            'Access-Control-Allow-Origin': '*',
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, PATCH, DELETE",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
            "Content-Type": "application/json",
            "responseHeader": "Access-Control-Allow-Origin",

          },
        body: json.encode({"id":recipient_id})
          );
      print("recipient id ${recipient_id}");

      print(uriResponse.statusCode);
      print(uriResponse.body.toString());
      if(uriResponse.statusCode==200){
        return Recipient.fromJson(jsonDecode(uriResponse.body));
        //   Navigator.pushNamed(context, "donor-show");
      }
    } finally {
      client.close();
    }
    final response =
    await http.get(Uri.parse('http://10.140.10.68/per/organd_back/public/index.php/api/recipient/1'));

    if (response.statusCode == 200) {
      print(response.body.toString());
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Recipient.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,

        // drawer: myDrawer(),
        body: Container(

          margin: EdgeInsets.only(top: SizeConfig.screenHeight* 0.02,left: SizeConfig.screenWidth* 0.05,right:  SizeConfig.screenWidth* 0.05 ),
           child: ListView(
             shrinkWrap: true,
             children: [
               SizedBox(
                height: 1000,
                 child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(26),
            color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                 SizedBox(height: SizeConfig.screenHeight*0.05,),
                 FutureBuilder<Recipient>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          var data = snapshot.data;

                          return Expanded(

                              child: ListView(



                                  children : [

                                    buildListTile("assets/icons/User Icon.svg","Full Name", "${data.firstName} ${data.middleName} ${data.lastName}"),

                                        buildListTile( "assets/icons/User Icon.svg","Email", "${data.email}"),
                                    buildListTile( "assets/icons/User Icon.svg","Phone", "${data.phone}"),
                                        buildListTile( "assets/icons/User Icon.svg","Sex", "${data.sex}"),
                                        buildListTile( "assets/icons/User Icon.svg","Blood Type", "${data.bloodType}"),
                                        buildListTile( "assets/icons/User Icon.svg","Organ Needed", "${data.organNeeded}"),

                                  ]

                              )


                          );





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
          ]
           ),
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }

  Container buildListTile(String icon, String title, String subtitle) {
    return

      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
dense: false,
                            minVerticalPadding: 8,

                            contentPadding:    EdgeInsets.all(SizeConfig.screenHeight*0.005),
                                  tileColor: Color(0xFFF5F6F9),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  leading: SvgPicture.asset(
                              icon,
                                color: kPrimaryColor,
                                width: 28,
                                  ) ,
                                title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color:kSecondaryColor ),),
                                subtitle: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("${subtitle!='null'?subtitle:"...."}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,fontStyle: FontStyle.normal, color: kPrimaryColor),)) ,
                                ),
      );
  }


  Future<http.Response> getRecipientData() async {

    var data = {
       'age': 34,
      'date': "2020-01-01",
    };
    //encode Map to JSON
    var body = json.encode(data);


    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('http://10.140.10.68/per/organd_back/public/index.php/api/recipient/${1}'),
          headers: {
            'Access-Control-Allow-Origin': '*',
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, PATCH, DELETE",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
            "Content-Type": "application/json",
            "responseHeader": "Access-Control-Allow-Origin",

          },
          body: body);
      print(uriResponse.statusCode);
      if(uriResponse.statusCode==200){
        Navigator.pushNamed(context, "donor-show");
      }
    } finally {
      client.close();
    }
  }







}