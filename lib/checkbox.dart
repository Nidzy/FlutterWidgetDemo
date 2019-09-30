import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(CheckBoxDemo());

class CheckBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: ChecxBoxDemoState());
  }
}

class ChecxBoxDemoState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<ChecxBoxDemoState> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  bool thurVal = false;
  bool friVal = false;
  bool satVal = false;
  bool sunVal = false;

  /// box widget
  /// [title] is the name of the checkbox
  /// [boolValue] is the boolean value of the checkbox
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
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
              //it will return selected checkbox name.
              print(title);
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dynamic Checkboxes"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  checkbox("Mon", monVal),
                  checkbox("Tu", tuVal),
                  checkbox("Wed", wedVal),
                  checkbox("Thur", thurVal),
                  checkbox("Fri", friVal),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  checkbox("Sat", satVal),
                  checkbox("Sun", sunVal),
                ],
              ),
            ],
          ),
        ));
  }
}
