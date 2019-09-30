import 'package:flutter/material.dart';

void main() => new MyButton();

//raised button demo
class MyButton extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Button Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: _MyButton(title: 'Flutter Demo Home Page'),
    );
  }
}

class _MyButton extends StatefulWidget {
  _MyButton({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _MyButtonState();
}

class _MyButtonState extends State<_MyButton> {
  int _number = 0;

  void subtractNumbers() {
    setState(() {
      if (_number > 0) {
        _number = _number - 1;
      }
    });
  }

  void addNumbers() {
    setState(() {
      _number = _number + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Raised Button"),
        ),
        body: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Text(
                _number.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 160.0,
                  fontFamily: 'Roboto',
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      padding: EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: addNumbers,
                      child: new Text("Add")),
                  new RaisedButton(
                    onPressed: subtractNumbers,
                    padding: EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.red,
                    child: new Text("Substract"),
                  ),
                ],
              ),
            ])));
    /* new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: addNumbers,
          child: new Text("Add"),
        ),
        new RaisedButton(
          textColor: Colors.white,
          color: Colors.red,
          onPressed: subtractNumbers,
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            "Subtract",
          ),
        ),
      ],
    )],*/
  }
}
