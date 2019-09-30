import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/model/radio_group_model.dart';

void main() => runApp(RadioGroup());

class RadioGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("DropDown Demo")),
            body: RadioGroupDemo()));
  }
}

class RadioGroupDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RadioGroupState();
}

class RadioGroupState extends State<RadioGroupDemo> {
  int _currVal = 1;
  String _currText = '';

  List<GroupModel> _group = [
    GroupModel(text: "Flutter.dev", index: 1),
    GroupModel(text: "Indusmile.com", index: 2),
    GroupModel(text: "Google.com", index: 3),
    GroupModel(text: "Yahoo.com", index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 350.0,
          child: Column(
            children: _group
                .map((t) => RadioListTile(
                      title: Text("${t.text}"),
                      groupValue: _currVal,
                      value: t.index,
                      onChanged: (val) {
                        setState(() {
                          _currVal = val.index;
                          _currText = t.text;
                        });
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    ));
  }
}
