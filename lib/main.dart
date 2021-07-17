import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:organd/routes.dart';
import 'package:organd/screens/register/components/body.dart';
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

class MyHomePage extends StatefulWidget {
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
    print("ip address");
    readCounter();
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Future<String> _getPath() {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }
  Future<File> get _localFile async {
    final path = await _getPath;
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
      // If encountering an error, return 0
      return "192.168.1.1";
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: new Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage("assets/images/organd.jpg"),

            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Row(
              children: <Widget>[


              ],
            ),
            Text(
              "WELCOME TO ODMS", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white, ),
            ),
            SizedBox(height: height*0.2,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width * 0.8, 2),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/donor-register");

              },
              child: Text(
                'DONOR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(width * 0.8, 3),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/recipient-register");
              },
              child: Text(
                'RECIPIENT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),

            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/login");
              },

              child:

              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20),
    child:
              Text("Already Registered ? Sign In", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.redAccent),),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),  
    );
  }
}
