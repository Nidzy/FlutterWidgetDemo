import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttercomponent_demo/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttercomponent_demo/login.dart';

void main() => runApp(ProfileScreen());

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Profile Detail"),
              actions: <Widget>[
                //action button
                IconButton(
                  icon: Icon(Icons.power_settings_new),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        // restrict outside touch close.
                        child: new CupertinoAlertDialog(
                          content: new Text(
                            "Are you sure you want to logout?",
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          actions: <Widget>[
                            //login button submit click
                            FlatButton(
                                onPressed: () {
                                  _clearPreference(context);
                                  /*  Navigator.pop(context, true);
                                  _clearPreference(context);*/
                                },
                                child: Text("Yes")),
                            FlatButton(
                              onPressed: () {
                                //ok button click
                                //discard the alert dialog.
//                                Navigator.pop(context, 'Discard');
                                Navigator.of(context, rootNavigator: true)
                                    .pop("Discard");
                              },
                              child: Text("No"),
                            )
                          ],
                        ));
                  },
                )
              ],
            ),
            body: ProfileDemo()));
  }
}

/*
* clear preference value
* */
_clearPreference(BuildContext context) async {
//  clear preference value:
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();

  //dissmiss confirmation dialog
  Navigator.of(context, rootNavigator: true).pop("Discard");

  //navigate to login screen.
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginPage()));
//  Navigator.pop(context, "");

  /*Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()))
      .then((result) {
    Navigator.of(context).pop();
  });*/

  /*Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginPage()));*/

  /* Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );*/
}

//perform logout on click of action menu logout button
class ProfileDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<ProfileDemo> {
  String username = "";
  String password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Name :",
              ),
            ),
            Text(" " + username),
          ],
        ),
        Divider(height: 0.5, indent: 0.0, endIndent: 0.0, color: Colors.pink),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Password :",
              ),
            ),
            Text(" " + password)
          ],
        ),
      ])),
    );
  }

  /*
  *  load profile details from preference 
  * */
  _loadProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username'));
      password = (prefs.getString('password'));

      print(username);
      print(password);
    });
  }
}
