import 'package:flutter/material.dart';
import 'package:organd/home.dart';
import 'package:organd/screens/control_center/show.dart';
import 'package:organd/screens/donation_center/show.dart';
import 'package:organd/screens/donor/register.dart';
import 'package:organd/screens/donor/show.dart';
import 'package:organd/screens/login/login.dart';
import 'package:organd/screens/profile/profile_screen.dart';
import 'package:organd/screens/recipient/register.dart';
import 'package:organd/screens/recipient/show.dart';
import 'package:organd/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  DonorRegister.routeName: (context) => DonorRegister(),

  DonorShow.routeName: (context)=> DonorShow(),
  ControlCenter.routeName: (context)=> ControlCenter(),

  RecipientRegister.routeName: (context) => RecipientRegister(),
  RecipientShow.routeName: (context)=> RecipientShow(),
  DonationCenterShow.routeName: (context)=> DonationCenterShow(),
  Login.routeName: (context)=> Login(),
  SplashScreen.routeName: (context)=> SplashScreen(),
  ProfileScreen.routeName: (context)=> ProfileScreen(),
  MyHomePage.routeName: (context)=> MyHomePage(title: "ODMS",),

};