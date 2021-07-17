
import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:organd/components/default_button.dart';
import 'package:organd/config/my_contstants.dart';
import 'package:organd/constants.dart';

import 'package:organd/size_config.dart';
import 'package:permission_handler/permission_handler.dart';


class MyHomePage extends StatefulWidget {
  static String routeName="/home";
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    requestStorage();
    print("ip address");
      readCounter().then((String s){
        print("ip set ${s}");
      MyConstants.setIpaddress(s.trim());

    });
     }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Future requestStorage() async{
    print("storage");
    var status = await Permission.storage.status;
    if (!status.isGranted) {

      await Permission.storage.request();
    }
  }
  Future<String> _getPath() {
    return ExtStorage.getExternalStorageDirectory();
  }
  Future<File> get _localFile async {
    final path = await _getPath();
    print("path $path");
    return File('$path/ip.txt');
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      print(e);
      // If encountering an error, return 0
      return "192.168.1.1";
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SizeConfig().init(context);
    return Scaffold(


      body: new Container(
        margin: EdgeInsets.symmetric(horizontal: width*0.05),

        child:
          Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[


            Text(
              "ODMS",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(36),
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Welcome to organ donation management system",
              textAlign: TextAlign.center,
            ),

        SizedBox(height: height*0.05,),

            Image.asset(
              "assets/images/splash_3.png",
              height: getProportionateScreenHeight(265),
              width: getProportionateScreenWidth(305),
            ),
            SizedBox(height: height*0.05,),


            Text( "Register as", style:  TextStyle(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic, fontSize: 28, color: kPrimaryColor),),
            SizedBox(height: height*0.02,),
            DefaultButton(

              text: "DONOR",
              press: () {
                Navigator.pushNamed(context, "/donor-register");
              },
            ),
            SizedBox(height: height*0.02,),
            DefaultButton(
              text: "RECIPIENT",
              press: () {
                Navigator.pushNamed(context, "/recipient-register");
              },
            ),


            SizedBox(height: 20,),
            GestureDetector(

              onTap: (){
                Navigator.pushNamed(context, "/login");
              },

              child:

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Padding(

                  padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20),
    child:
                Text( "Already Registered ? Sign In", style:  TextStyle(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic, fontSize: 19, color: Colors.blue),),
                ),
        ]
              ),
            )
          ],
        ),

      ),


    );
  }
}
