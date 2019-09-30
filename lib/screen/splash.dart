import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttercomponent_demo/bottomnavigationbar.dart';

/*void main() {
  runApp(
    Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}*/

//main function to run the application.
void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Splash(),
    routes: <String, WidgetBuilder>{
      '/Login': (BuildContext context) => LoginPage(),
      '/Home': (BuildContext context) => NavigationScreen()
    },
  ));
}

/*
*  splash screen as stateful widget.
* */
class Splash extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //makes view as wrap content, wrap content (height and width)
      body:
          /*Wrap(children: <Widget>[
          new Image.asset('images/SplashScreen.png',fit: BoxFit.fill)
        ]*/
          /*new Center(child: new Text("hiii"))*/ /*new Image.asset('images/SplashScreen.png'))*/

          Align(
              alignment: Alignment.center,
              child: Image.asset('images/flutter.png')),
    );
  }

  /*
  * init state and call the method start time .
  *  */
  @override
  void initState() {
    super.initState();
    startTime();
  }

  /*
  *  Navigate to login/home screen based on preference value.
  * */
  void navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    print(username);

    if (username != null) {
      Navigator.of(context).pushReplacementNamed('/Home');
    } else {
      Navigator.of(context).pushReplacementNamed('/Login');
    }
  }

/*Future<void> main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var password = prefs.getString('password');
    print(username);
    print(password);
  }*/
}
