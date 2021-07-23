import 'package:flutter/material.dart';
import 'package:organd/routes.dart';
import 'package:organd/screens/splash/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organ Donation Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: SplashScreen.routeName,
     // home:MyHomePage(title: "ODMS"),
     routes: routes,

    );
  }
}



