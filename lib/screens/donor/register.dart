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


class DonorRegister extends StatefulWidget {
  static String routeName="/donor-register";
  String password;


  @override
  _DonorRegister createState() => new _DonorRegister();
}

class _DonorRegister extends State<DonorRegister> {

  String genderValue="Male";
  int organValue=1;
  int bloodValue=1;
  String password;
  _DonorRegister(){

  }

  String _first_name;
  String  _middle_name ;
  String  _last_namee ;
 String _phone ;
 String _email ;
 String _password ;
 String _number;
  final _formKey = GlobalKey<FormState>();
  bool toMe;
  Future<http.Response> requiredList;
  String url;
  List organ_list;
  List blood_list;
  Future<http.Response> response;
  @override
  initState() {

    super.initState();
    url= MyConstants.ipAddress;
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
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        // drawer: myDrawer(),
        body:  FutureBuilder<http.Response>(
        future: response,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data);
        var data = snapshot.data;

        return Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight* 0.02),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              shrinkWrap: true,
              children: <Widget>[
              Padding(

                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight*0.05, horizontal: 16.0),
                  child:Form(
                    key: _formKey,

                    child: Column(

                      children: <Widget>[


                        Text(
                          "Donor Register",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(28),
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),

                          TextFormField(

                            keyboardType: TextInputType.text,

                            onSaved: (newValue) => _first_name = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kNamelNullError);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                addError(error: kNamelNullError);
                                return "";
                              }
                              return null;
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

                            keyboardType: TextInputType.text,
                            onSaved: (newValue) => _middle_name = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kNamelNullError);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                addError(error: kNamelNullError);
                                return "";
                              }
                              return null;
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

                            keyboardType: TextInputType.text,
                            onSaved: (newValue) => _last_namee = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kNamelNullError);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                addError(error: kNamelNullError);
                                return "";
                              }
                              return null;
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
                            Text("Select Gender",  style: TextStyle(fontWeight: FontWeight.w400 ,fontStyle: FontStyle.italic,color:Colors.black ,height: 2.0,fontSize: 18)),
                            SizedBox(width: SizeConfig.screenWidth*0.07,),
                            DropdownButton(
                              hint: Text('Select Gender'),

                              value:genderValue,
                              items: [
                                DropdownMenuItem(child: Text("Male"),value: "Male",),
                                DropdownMenuItem(child: Text("Female"), value: "Female",),
                              ],
                              onChanged:(String text){
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
                            Text("Birth Date",  style: TextStyle(fontWeight: FontWeight.w400 ,fontStyle: FontStyle.italic,color:Colors.black ,height: 2.0,fontSize: 18)),
                            SizedBox(width: SizeConfig.screenWidth*0.09,),
                            RaisedButton(
                              onPressed: () => _selectDate(context),
                              child: Text("${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}"),
                            ),
                          ],
                        ),

                        SizedBox(height: getProportionateScreenHeight(30)),
                        Row(
                          children: [
                            Text("Organ to be donored:-",  style: TextStyle(fontWeight: FontWeight.w400 ,fontStyle: FontStyle.italic,color:Colors.black ,height: 2.0,fontSize: 18)),
                            SizedBox(width: SizeConfig.screenWidth*0.07,),
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
                 ]
                        ),

                        SizedBox(height: getProportionateScreenHeight(30)),
                          TextFormField(
                            onSaved: (newValue) => _email = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kPassNullError);
                              } else if (value.length >= 4) {
                                removeError(error: kShortPassError);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                addError(error: kPassNullError);
                                return "";
                              } else if (value.length < 4) {
                                addError(error: kShortPassError);
                                return "";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,


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
                            onSaved: (newValue) => _phone = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kPassNullError);
                              } else if (value.length >= 4) {
                                removeError(error: kShortPassError);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                addError(error: kNamelNullError);
                                return "";
                              } else if (value.length < 10) {
                                addError(error: kShortPassError);
                                return "";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,



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
                            onSaved: (newValue) => _password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kPassNullError);
                              } else if (value.length >= 4) {
                                removeError(error: kShortPassError);
                              }
                              return null;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                addError(error: kPassNullError);
                                return "";
                              } else if (value.length < 4) {
                                addError(error: kShortPassError);
                                return "";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,

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
                          child: Text("Cancel",  style: TextStyle(fontWeight: FontWeight.w300,color:Colors.red,height: 2.0,fontSize: 18)),
                          onPressed: (){
                            Navigator.pop(context);
                            print("Cancel");
                          },
                        ),


                    ],
                  ),

          ),


                  )


          ]
            )
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
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    var data = {
      'first_name': _first_name,
      'middle_name': _middle_name,
      'last_name': _last_namee,
      'phone': _phone,
      'password': _password,

      'email': _email,
      'sex': genderValue,
      'birth_date': selectedDate.toIso8601String(),
      'blood_type': bloodValue,
      'organ': organValue,
    };
    //encode Map to JSON
    var body = json.encode(data);


    var client = http.Client();
    try {

      String myurl='${url}/api/donor/create';
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
      if(uriResponse.statusCode==200){
        var data = json.decode(uriResponse.body);
        prefs.setInt('recipient_id',null);
        prefs.setInt('donor_id', data['data']['donor_id']);
        Navigator.pushNamed(context, "/donor-show");
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