import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttercomponent_demo/bottomnavigationbar.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPageDemoState();
    /*MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Login Demo")),
        body: LoginPageDemoState(),
      ),
    );*/
  }
}

class LoginPageDemoState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPageDemoState> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool checkValue = false;

  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

  final FocusNode _uNameFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  SharedPreferences sharedPreferences;

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            //here we need to change the state for check/uncheck the checkbox.
            setState(() {
              switch (title) {
                case "Mon":
                  monVal = value;
                  break;
                case "Tu":
                  tuVal = value;
                  break;
                case "Wed":
                  wedVal = value;
                  break;
                case "Thur":
                  thurVal = value;
                  break;
                case "Fri":
                  friVal = value;
                  break;
                case "Sat":
                  satVal = value;
                  break;
                case "Sun":
                  sunVal = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    //getCredential();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            //it prevents to resize the view when keyboard appears
            appBar: new AppBar(
              title: Text("Login"),
              elevation: 5,
            ),
            body: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(16.0),
                              alignment: Alignment.center,
                              child: Card(
                                  elevation: 3,
                                  shape: BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Form(
                                          /*key: _formKey,
                              autovalidate: _autoValidate,*/
                                          child: _body()))))
                        ])))));

    /*child: _body(),
            )));*/
  }

  Widget _body() {
    return new Column(
      children: <Widget>[
        TextFormField(
          controller: username,
          focusNode: _uNameFocus,
          onFieldSubmitted: (term) {
            _fieldFocusChange(context, _uNameFocus, _passFocus);
          },
          decoration: InputDecoration(
              hintText: "UserName" /*Strings.uname*/,
              // called from static string file
              hintStyle: new TextStyle(color: Colors.pinkAccent)),
        ),
        TextFormField(
            controller: password,
            obscureText: true,
            focusNode: _passFocus,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                hintText: "Password" /*Strings.pwd*/, //
                hintStyle: new TextStyle(color: Colors.pinkAccent))),
        /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              checkbox("Mon", monVal),
              checkbox("Tu", tuVal),
              checkbox("Wed", wedVal),
              checkbox("Thur", thurVal),
              checkbox("Fri", friVal),
            ],
          ),*/

        /*new Checkbox(
              value: checkValue,
              onChanged: (bool value) {
                setState(() {
                  checkValue = value;
                });
              }),
*/
        new CheckboxListTile(
          value: checkValue,
          onChanged: (bool value) {
            setState(() {
              checkValue = value;
            });
          },
          title: new Text("Remember me"),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        new Container(
          decoration:
              new BoxDecoration(border: Border.all(color: Colors.black)),
          child: new ListTile(
            title: new Text(
              "Login",
              textAlign: TextAlign.center,
            ),
            onTap: _navigator,
          ),
        )
      ],
    );
  }

  /*
  * save login details to preference
  * */
  _saveLoginValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username.text);
    prefs.setString("password", password.text);
  }

  //focus from one field to other field
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _navigator() {
    if (username.text.length != 0 && password.text.length != 0) {
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      );*/

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavigationScreen()));

      _saveLoginValues();
      /* Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (BuildContext context) => ListDemo()),
          (Route<dynamic> route) => false);*/
    } else {
      showDialog(
          context: context,
          barrierDismissible: false, // restrict outside touch close.
          child: new CupertinoAlertDialog(
            content: new Text(
              "username or password \ncan't be empty",
              style: new TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[
              //login button submit click
              FlatButton(
                  onPressed: () {
                    //ok button click
                    //discard the alert dialog.
//                    Navigator.pop(context, 'Discard');
                    //dissmiss confirmation dialog
                    Navigator.of(context, rootNavigator: true).pop("Discard");
                  },
                  child: new Text("OK"))
            ],
          ));
    }
  }
}
