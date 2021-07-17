import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:organd/components/custom_surfix_icon.dart';
import 'package:organd/components/default_button.dart';
import 'package:organd/components/form_error.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:organd/constants.dart';
import 'package:organd/helper/keyboard.dart';
import 'package:organd/home.dart';
import 'package:organd/screens/donor/show.dart';
import 'package:organd/screens/profile/profile_screen.dart';
import 'package:organd/size_config.dart';


class Login extends StatefulWidget {
  static String routeName="/login";
  String password;


  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {


  String password;
  _Login(){

  }

  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool toMe;
  String hash="%23";

  @override
  initState() {
    toMe=false;
    super.initState();
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
  String email;

  bool remember = false;
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
          margin: EdgeInsets.only(top: SizeConfig.screenHeight*0.2),

          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            shrinkWrap: true,
            children: <Widget>[
              Padding(

                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
                    child:Form(
                      key: _formKey,
                      child: Column(

                        children: <Widget>[

                          SizedBox(height: getProportionateScreenHeight(30)),

                          Text(
                            "Sign In Here",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(24),
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),




                          buildEmailFormField(),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          buildPasswordFormField(),
                          SizedBox(height: getProportionateScreenHeight(30)),





                          Divider(color: Colors.black26,),




                          FormError(errors: errors),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          DefaultButton(
                            text: "SIGN IN",
                            press: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                // if all are valid then go to success screen
                                KeyboardUtil.hideKeyboard(context);
                                postRequest();
                                Navigator.pushNamed(context, DonorShow.routeName);
                              }
                            },
                          ),
                          FlatButton(
                            child: Text("Not Registered Yet?",  style: TextStyle(fontWeight: FontWeight.w300,fontStyle: FontStyle.italic, color:Colors.red,height: 2.0,fontSize: 19)),
                            onPressed: (){
                              Navigator.pushNamed(context,ProfileScreen.routeName);

                            },
                          ),

                        ],
                      ),
                    ),),



            ],
          ),
        ));
  }


  Future<http.Response> postRequest () async {

    var data = {

      'password': password,
      'email': email,

    };
    //encode Map to JSON
    var body = json.encode(data);
print(data.toString());

    var client = http.Client();
    try {
      String url= MyConstants.ipAddress;
      var uriResponse = await client.post(Uri.parse('${url}/api/user/login'),
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
        Navigator.pushNamed(context, "/recipient-show");
      }
      else{
        AlertDialog alert= AlertDialog(
          title: Text("Error",style: TextStyle(color: kPrimaryColor),),
          content: Text("Invalid Credentials"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Text("try again"),
            ),
          ],
        );
        return showDialog(
        barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            //prevent Back button press
            return WillPopScope(
                onWillPop: (){},
                child: alert);
          },
        );
      }
    } finally {
      client.close();
    }
  }



  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
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
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),

          border: OutlineInputBorder(),

      ),
    );
  }



}