import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class MyHelper{

  static getPref() async{
    final prefs = await SharedPreferences.getInstance();

    return prefs;
  }
  static sendRequest(context,url_append,data) async{
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
}