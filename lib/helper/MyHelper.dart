import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:organd/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MyHelper{

  Future<SharedPreferences> getPref()async {
    final prefs = await SharedPreferences.getInstance();

    return prefs;
  }
  Future<http.Response> sendRequest(context,url_append,data) async{
    var client = http.Client();
    try {
      var body = json.encode(data);
      String url= MyConstants.ipAddress;
      String myurl='${url}${url_append}';
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
     return uriResponse;
    } finally {
      client.close();
    }

   }
   showAlertDialog(context,String title,String message,bool button,String buttonTitle){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return AlertDialog(
          title: Text(title,style: TextStyle(color: kPrimaryColor),),
          content: Text(message),
          actions: <Widget>[
            if(button)
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: Text(buttonTitle),
              ),
          ],
        );
      },
    );

   }

  Future<DateTime> selectDate(BuildContext context,selectedDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
    return picked;
  }
}