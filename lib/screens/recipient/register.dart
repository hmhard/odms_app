import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:organd/components/default_button.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:organd/constants.dart';
import 'package:organd/helper/keyboard.dart';
import 'package:organd/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RecipientRegister extends StatefulWidget {
  static String routeName="/recipient-register";
  String password;


  @override
  _RecipientRegister createState() => new _RecipientRegister();
}

class _RecipientRegister extends State<RecipientRegister> {

  Future<http.Response> requiredList;
  String genderValue="Male";
  int bloodValue=1;
  int organValue=1;
  String password;
  _RecipientRegister(){

  }

  final TextEditingController _first_name = new TextEditingController();
  final TextEditingController _middle_name = new TextEditingController();
  final TextEditingController _last_namee = new TextEditingController();
  final TextEditingController _phone = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _number = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
List organ_list;
List blood_list;
Future<http.Response> response;
String url;

  @override
  initState() {
    super.initState();
      url= MyConstants.ipAddress;
    print("url ${url}");


    response=getBloodList();
    print(organ_list);
    print(blood_list);
  }


  DateTime selectedDate = DateTime.utc(1999);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2000));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        // drawer: myDrawer(),
        body:

        FutureBuilder<http.Response>(
        future: response,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            var data = snapshot.data;

            return Container(
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(

                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.screenHeight * 0.05,
                        horizontal: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(

                        children: <Widget>[


                          Text(
                            "Recipient Register",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(28),
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          TextFormField(
                            controller: _first_name,
                            keyboardType: TextInputType.text,
                            validator: (str) {
                              str.length > 10 ? "Not valid " : null;
                            },

                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              hintText: "First Name",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: getProportionateScreenHeight(30)),


                          TextFormField(
                            controller: _middle_name,
                            keyboardType: TextInputType.text,
                            validator: (str) {
                              str.length > 10 ? "Not valid " : null;
                            },

                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Middle Name",
                              hintText: "Middle Name",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: getProportionateScreenHeight(30)),
                          TextFormField(
                            controller: _last_namee,
                            keyboardType: TextInputType.text,
                            validator: (str) {
                              str.length > 10 ? "Not valid " : null;
                            },

                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              hintText: "Last Name",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: getProportionateScreenHeight(30)),


                          Row(
                            children: [
                              Text("Select Gender", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  height: 2.0,
                                  fontSize: 18)),
                              SizedBox(width: SizeConfig.screenWidth * 0.07,),
                              DropdownButton(
                                hint: Text('Select Gender'),

                                value: genderValue,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Male"), value: "Male",),
                                  DropdownMenuItem(
                                    child: Text("Female"), value: "Female",),
                                ],
                                onChanged: (String text) {
                                  print(text);
                                  setState(() {
                                    genderValue = text;
                                  });
                                },

                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          Row(
                            children: [
                              Text("Blood Type:-", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  height: 2.0,
                                  fontSize: 18)),
                              SizedBox(width: SizeConfig.screenWidth * 0.07,),
                              DropdownButton(
                                hint: Text('Blood Type'),
                                value: bloodValue.toString(),


                                //value: organValue,
                                items:
                                blood_list.map((  value) {
                                  print(value);
                                  return DropdownMenuItem<String>(
                                    value: value['id'].toString(),
                                    child: new Text(value['name']),
                                  );
                                }).toList(),

                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    print(value);
                                    bloodValue =    int.parse(value);
                                  });
                                },

                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          Row(
                            children: [
                              Text("Organ needed:-", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  height: 2.0,
                                  fontSize: 18)),
                              SizedBox(width: SizeConfig.screenWidth * 0.07,),
                              DropdownButton(
                                hint: Text('Organ'),
                                value: organValue.toString(),


                                //value: organValue,
                                items:
                                organ_list.map((  value) {
                                  print(value);
                                  return DropdownMenuItem<String>(
                                    value: value['id'].toString(),
                                    child: new Text(value['name']),
                                  );
                                }).toList(),

                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    print(value);
                                    organValue =    int.parse(value);
                                  });
                                },

                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          Row(
                            children: [
                              Text("Birth Date", style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  height: 2.0,
                                  fontSize: 18)),
                              SizedBox(width: SizeConfig.screenWidth * 0.09,),
                              RaisedButton(
                                onPressed: () => _selectDate(context),
                                child: Text("${selectedDate.year}:${selectedDate
                                    .month}:${selectedDate.day}"),
                              ),
                            ],
                          ),

                          SizedBox(height: getProportionateScreenHeight(30)),
                          TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (str) {
                              str.length > 10 ? "Not valid " : null;
                            },


                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Email",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),


                          SizedBox(height: getProportionateScreenHeight(30)),
                          TextFormField(
                            controller: _phone,
                            keyboardType: TextInputType.text,
                            validator: (str) {
                              str.length > 10 ? "Not valid " : null;
                            },


                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: "Phone",
                              hintText: "Phone",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),


                          SizedBox(height: getProportionateScreenHeight(30)),

                          TextFormField(
                            controller: _number,
                            keyboardType: TextInputType.number,
                            validator: (str) {
                              str.length != 10 ? "Not valid " : null;
                            },
                            maxLines: 1,
                            autocorrect: false,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          SizedBox(height: getProportionateScreenHeight(30)),

                          DefaultButton(
                            text: "REGISTER",
                            press: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                // if all are valid then go to success screen
                                KeyboardUtil.hideKeyboard(context);
                                postRequest();
                              }
                            },
                          ),

                          FlatButton(
                            child: Text("Cancel", style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Colors.red,
                                height: 2.0,
                                fontSize: 18)),
                            onPressed: () {
                              Navigator.pop(context);
                              print("Cancel");
                            },
                          ),


                        ],
                      ),
                    ),
                  ),


                ],
              ),
            );
          }
          else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return  Center(child: CircularProgressIndicator(semanticsLabel: "Loading..",));
        }
        ), );
  }


  Future<http.Response> postRequest () async {

    final prefs = await SharedPreferences.getInstance();

    var data = {
      'first_name': _first_name.text,
      'middle_name': _middle_name.text,
      'last_name': _last_namee.text,
      'phone': _phone.text,
      'password': _password.text,
      'email': _email.text,
      'sex': genderValue,
      'birth_date': selectedDate.toIso8601String(),
      'blood_type': bloodValue,
      'organ': organValue,


    };
    //encode Map to JSON
    var body = json.encode(data);


    var client = http.Client();
    try {

         print(url);

         String myurl='${url}/api/recipient/create';
      var uriResponse = await client.post(Uri.parse(myurl),
          headers: {
            'Access-Control-Allow-Origin': '*',
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, PATCH, DELETE",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
            "Content-Type": "application/json",
            "responseHeader": "Access-Control-Allow-Origin",

          },
          body: body);
      print(uriResponse.statusCode);
      print(uriResponse.body.toString());
      print(uriResponse.request.url);
      if(uriResponse.statusCode==200){
        print(uriResponse.body.toString());

        var data = json.decode(uriResponse.body);

        prefs.setInt('recipient_id', data['data']['recipient_id']);
        Navigator.pushNamed(context, "/recipient-show");
      }
    } finally {
      client.close();
    }
  }

  Future<http.Response> getOrganList () async {


    var data = {
      "active":1
     };
    //encode Map to JSON
    var body = json.encode(data);


    var client = http.Client();
    try {

         print(url);

         String myurl='${url}/api/setting/organ-list';
      var uriResponse = await client.post(Uri.parse(myurl),
          headers: {
            'Access-Control-Allow-Origin': '*',
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, PATCH, DELETE",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
            "Content-Type": "application/json",
            "responseHeader": "Access-Control-Allow-Origin",

          },
          body: body);
      print(uriResponse.statusCode);
      print(uriResponse.request.url);
      if(uriResponse.statusCode==200){
        print(uriResponse.body.toString());

        var data = json.decode(uriResponse.body);
 organ_list=data['data'];

      }
    } finally {
      client.close();
    }
  }




  Future<http.Response> getBloodList () async {

   await getOrganList();
    var data = {
      "active":1
     };
    //encode Map to JSON
    var body = json.encode(data);


    var client = http.Client();
    try {

         print(url);

         String myurl='${url}/api/setting/blood-list';
      var uriResponse = await client.post(Uri.parse(myurl),
          headers: {
            'Access-Control-Allow-Origin': '*',
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS, PUT, PATCH, DELETE",
            "Access-Control-Allow-Headers": "Origin, X-Requested-With, Content-Type, Accept",
            "Content-Type": "application/json",
            "responseHeader": "Access-Control-Allow-Origin",

          },
          body: body);
      print(uriResponse.statusCode);
      print(uriResponse.request.url);
      if(uriResponse.statusCode==200){
        print(uriResponse.body.toString());

        var data = json.decode(uriResponse.body);
 blood_list=data['data'];
  return uriResponse;

      }
    } finally {
      client.close();
    }
  }







}