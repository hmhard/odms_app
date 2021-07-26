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


class AppointmentShow extends StatefulWidget {
  static String routeName="/appointment-show";
  String password;


  @override
  _Appointment createState() => new _Appointment();
}

class _Appointment extends State<AppointmentShow> with MyHelper {
  Future<Appointment> getAppointment;
  String url;
  String status;
  String password;
 int donor_id;
  final _formKey = GlobalKey<FormState>();


  DateTime selectedDate = DateTime.utc(1999);

  @override
  void initState() {
    super.initState();
    url= MyConstants.ipAddress;

    getAppointment= getAppointmentData();

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
                      "Appointment",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(26),
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    SizedBox(height: SizeConfig.screenHeight*0.05,),
                    FutureBuilder<Appointment>(
                      future: getAppointment,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {

                          print(snapshot.data);


                          var data = snapshot.data;
                          if(data.status==null){
                            return Center(
                              child: Text("No Data"),
                            );
                          }

                          if(data.status==0){
                             status="Appointed";

                          }
                          else if(data.status==2){

                             status="PostPoned";
                          }
                          else if(data.status==1){

                             status="Approved";
                          }

                          return Expanded(

                              child: ListView(



                                  children : [

                                    buildListTile("assets/icons/User Icon.svg","Full Name", "${data.firstName} ${data.middleName} ${data.lastName}"),

                                    buildListTile( "assets/icons/User Icon.svg","Status", "${status}"),
                                    buildListTile( "assets/icons/User Icon.svg","Appointment Date", "${ data.appointmentDate.toString() }"),
                                    SizedBox(height: getProportionateScreenHeight(30)),

                                    if(data.status==3)
                                      Text(
                                        "Appoitment processed",
                                        style: TextStyle(
                                          fontSize: getProportionateScreenWidth(26),
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                    if(data.status!=3 && data.status!=2)

                                      DefaultButton(
                                        text: "Approve",
                                        press: () {
                                          if (true) {
                                            print('approved');
                                            try {
                                              var dataa = {
                                                'donor_id': donor_id,
                                                'action': true,
                                                'appointment_id': data.id,
                                                'approve': true,

                                              };
                                              Future<http.Response> uriResponse= sendRequest(context,'/api/donor/appointment-show',dataa);
                                               uriResponse.then((value)  {
                                                 print("val");
                                                 print(value);

                                                showAlertDialog(context, "Success", "Approved Successfully", true, "Close");

                                                Navigator.popAndPushNamed(context, AppointmentShow.routeName);
                                              });

                                            } finally {
                                              //client.close();
                                            }

                                          }
                                        },
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              30)),
                                    if(data.status!=3)
                                      DefaultButton(
                                        text: "PostPone",
                                        press: () {
                                          return showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              //prevent Back button press
                                              return AlertDialog(
                                                title: Text("Postpone",style: TextStyle(color: kPrimaryColor),),
                                                content: Text("select Date and postpone"),
                                                actions: <Widget>[
                                                  Form(
                                                    key: _formKey,
                                                    child: Column(

                                                      children: <Widget>[

                                                        SizedBox(height: getProportionateScreenHeight(30)),


                                                        RaisedButton(
                                                          onPressed: (){

                                              selectDate(context,data.appointmentDate).then((value) =>
                                                  setState(() {
                                                    selectedDate = value;
                                                  })
                                              );
    },
                                                          child: Text("${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}"),
                                                        ),





                                                        Divider(color: Colors.black26,),




                                                       // FormError(errors: errors),
                                                        SizedBox(height: getProportionateScreenHeight(15)),
                                                        DefaultButton(
                                                          text: "Submit",
                                                          press: () {
                                                            if (_formKey.currentState.validate()) {
                                                              _formKey.currentState.save();
                                                              // if all are valid then go to success screen
                                                              KeyboardUtil.hideKeyboard(context);
                                                           //   postRequest();
                                                              try {
                                                                var dataa = {
                                                                  'donor_id': donor_id,
                                                                  'action': true,
                                                                  'appointment_id': data.id,
                                                                  "change_appointment":true,
                                                                  "appointment_date":selectedDate.toIso8601String(),

                                                                };
                                                            Future<http.Response> uriResponse= sendRequest(context,'/api/donor/appointment-show',dataa);
                                                                uriResponse.then((value)  {
                                                                  print("val");
                                                                  print(value);

                                                                  showAlertDialog(context, "Success", "Postpone request sent Successfully", true, "Close");

                                                                });

                                                              } finally {
                                                                Navigator.pushNamed(context, AppointmentShow.routeName);

                                                                //client.close();
                                                              }

                                                            }
                                                          },
                                                        ),


                                                      ],
                                                    ),
                                                  ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },

                                                      child: Text("Cancel"),
                                                    ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),


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


  Future<Appointment> getAppointmentData() async {

    final prefs = await SharedPreferences.getInstance();

    donor_id= await prefs.getInt('donor_id');

    var data = {
      'donor_id': donor_id,

    };

    var client = http.Client();
    try {
     Future<http.Response> uriResponse= sendRequest(context,'/api/donor/appointment-show',data);
    return uriResponse.then((value)  {
        return Appointment.fromJson(jsonDecode(value.body));

    });

    } finally {
      client.close();
    }
  }



}