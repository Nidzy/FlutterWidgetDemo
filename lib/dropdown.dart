import 'package:flutter/material.dart';

void main() => runApp(DropDownDemo());

class DropDownDemo extends StatelessWidget {
  /*SettingsWidget({Key key}) : super(key: key);*/

  /*@override
  _SettingsWidgetState createState() => new _SettingsWidgetState();*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appTitle = 'DropDown demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: DemoDropDown(),
      ),
    );
  }
}

class DemoDropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsWidgetState();
  }
}

class SettingsWidgetState extends State<DemoDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("Please choose your city: "),
              Container(
                padding: EdgeInsets.all(16.0),
              ),
              DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
            ])));
  }

  List _cities = [
    "Cluj-Napoca",
    "Bucuresti",
    "Timisoara",
    "Brasov",
    "Constanta"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
//    print(_currentCity);
    super.initState();
  }

  //fetch selected item from dropdown.
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    for (String city in _cities) {
      items.add(DropdownMenuItem(value: city, child: Text(city)));
    }
    return items;
  }

  //fetch selected item from dropdown :
  List<DropdownMenuItem<String>> getItem() {
    List<DropdownMenuItem<String>> items = List();
    for (String city in _cities) {
      items.add(DropdownMenuItem(value: city, child: Text(city)));
    }
  }

  //dropdown item onChanged state.
  void changedDropDownItem(selectedCity) {
    setState(() {
      _currentCity = selectedCity;
      print(_currentCity);
    });
  }
}
