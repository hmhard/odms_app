import 'package:flutter/material.dart';

import 'package:organd/components/coustom_bottom_nav_bar.dart';
import 'package:organd/components/default_button.dart';
import 'package:organd/constants.dart';

import 'package:organd/enums.dart';

import 'package:organd/size_config.dart';

 

class ControlCenter extends StatefulWidget {
  static String routeName="/control";
  String password;


  @override
  _ControlCenter createState() => new _ControlCenter();
}

class _ControlCenter extends State<ControlCenter> {


  String password;
  _ControlCenter(){

  }
  @override
  void initState() {
    super.initState();

  }


  int currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      // drawer: myDrawer(),
      body: Container(

        margin: EdgeInsets.only(top: SizeConfig.screenHeight* 0.02,left: SizeConfig.screenWidth* 0.05,right:  SizeConfig.screenWidth* 0.05 ),
        child:   SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Welcome Friend",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(26),
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),   Text(
                        "Home Page\n\n Working on it",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(50)),
                      Text(
                        "I will come back on the next presentation\n c u later",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Column(
                            children: <Widget>[
                              Spacer(),

                              Spacer(flex: 1),
                              DefaultButton(
                                text: "Select",
                                press: () {

                                },
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),





            // By default, show a loading spinner.



      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }



 







}