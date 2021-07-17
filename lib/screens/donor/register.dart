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
  _SendMoney createState() => new _SendMoney();
}

class _SendMoney extends State<DonorRegister> {

  String genderValue="Male";
  String password;
  _SendMoney(){

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
  String hash="%23";
  String url;
  @override
  initState() {
    toMe=false;
    super.initState();
    url= MyConstants.ipAddress;
  }

  changedToOther(){
    setState(() {
      toMe=!toMe;
    });
  }
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
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
        body: Container(
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
                  )
              ),
            ],
          ),
        ));
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
      'age': 34,
      'date': "2020-01-01",
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
      if(uriResponse.statusCode==200){
        var data = json.decode(uriResponse.body);
        prefs.setInt('recipient_id', data['data']['donor_id']);
        Navigator.pushNamed(context, "/donor-show");
      }
    } finally {
      client.close();
    }
  }







}