import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(FormDemo());

/*form demo with validation, input type, auto next, snackbar, email,phone validation */
class FormDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appTitle = 'Form Validation demo';
    return MaterialApp(
      title: appTitle,
      //remove debug mode banner
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: DemoForm(),
      ),
    );
  }
}

class DemoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyCustomFrom();
  }
}

class MyCustomFrom extends State<DemoForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Container(
              padding: EdgeInsets.all(16.0),
              child: Card(
                  elevation: 3,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: formUi()))))
        ])));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//  bool globalKey = false;
  bool _autoValidate = false;
  String _name, _city, _addess, _number, _email;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  //get the text from controller.
  final nameController = TextEditingController();

  int _radioValue1 = -1;
  int correctScore = 0;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;
  int _radioValue5 = -1;

  Widget formUi() {
    return Column(
      // center submit button
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            controller: nameController,
            focusNode: _nameFocus,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _nameFocus, _numberFocus);
            },

            //textDirection: TextDirection.rtl,
            validator: (name) {
              if (name.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
            onSaved: (String name) {
              _name = name;
            }),
        TextFormField(
            decoration: InputDecoration(labelText: "Number"),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: _numberFocus,
            autofocus: false,
            maxLength: 10,

            //for hiding the 1/10 lable from the form field.
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _numberFocus, _addressFocus);
            },
            validator: validMobile,
            /*validator: (number) {
              if (number.isEmpty) {
                return 'Please enter Number';
              }
              return null;
            },*/
            onSaved: (String number) {
              _number = number;
            }),
        TextFormField(
            decoration: InputDecoration(labelText: "Address"),
            keyboardType: TextInputType.text,
            focusNode: _addressFocus,
            autofocus: false,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _addressFocus, _emailFocus);
            },
            textInputAction: TextInputAction.next,
            validator: (address) {
              if (address.isEmpty) {
                return 'Please enter address';
              }
              return null;
            },
            onSaved: (String address) {
              _addess = address;
            }),
        TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocus,
            autofocus: false,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _emailFocus, _cityFocus);
            },
            textInputAction: TextInputAction.next,
            validator: validateEmail,
            /*validator: (email) {
              if (email.isEmpty) {
                return 'Please enter email address';
              }
              return null;
            },*/
            onSaved: (String email) {
              _email = email;
            }),
        TextFormField(
            decoration: InputDecoration(labelText: "city"),
            keyboardType: TextInputType.text,
            focusNode: _cityFocus,
            autofocus: false,
            textInputAction: TextInputAction.done,
            validator: (city) {
              if (city.isEmpty) {
                return 'Please enter city';
              }
              return null;
            },
            onSaved: (String city) {
              _city = city;
            }),
        Padding(padding: EdgeInsets.all(15.0)),
        Align(
            alignment: Alignment.topLeft,
            child: DropdownButton(
              value: _currentCity,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            )),
        Text("Please choose your city: ", textAlign: TextAlign.right),
        Container(
          padding: EdgeInsets.all(5.0),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  Text(
                    'Item1',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Radio(
                      value: 1,
                      groupValue: _radioValue1,
                      onChanged: _handleRadioValueChange1,

                      //active color of radio button.
                      activeColor: Colors.pinkAccent),
                  Text(
                    'Item2',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  Text(
                    'Item3',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ])),
        Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              tooltip: "Add",
              child: Icon(Icons.add),
              onPressed: _showDialog,
            ))

        /*DropdownButton(
          value: _currentCity,
          items: _dropDownMenuItems,
          onChanged: */ /*(string) =>
              setState(() => _currentCity = string),*/ /* changedDropDownItem
        )*/ /*))*/,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            color: Colors.pinkAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(5),
            onPressed: () {
              FocusScope.of(context).requestFocus(_nameFocus);
              _validateInput();

//                if (_formKey.currentState.validate()) {
//                  _formKey.currentState.save();
//                  //if the form is valid display a snackbar
//                  /*Scaffold.of(context).showSnackBar(SnackBar(
//                            content: Text("Processing Data"),
//                            behavior: SnackBarBehavior.floating,
//                          ));*/
//                } else {
//                  setState(() {});
//                }
            },
            //submit button text
            child: Text('submit'),
            colorBrightness: Brightness.dark,
          ),
        ),
      ],
    );
  }

  //focus from one field to other field
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _validateInput() {
    if (_formKey.currentState.validate()) {
      //if all data is correct then save data to the variable
      _formKey.currentState.save();

      //print all form values
      print(_name);
      print(_number);
      print(_addess);
      print(_email);
      print(_city);

      _showDialog();
      /* showDialog(
          context: context,
          barrierDismissible: false, // cancellable false
          builder: (context) {
            return AlertDialog(
              key: Key("dialog"),
//              content: Text("Form Submit Success"),
              content: Text("name: " + nameController.text),
              actions: <Widget>[
                RaisedButton(
                  child: Text("Ok"),
                  disabledTextColor: Colors.pinkAccent,
                  disabledColor: Colors.transparent,
                ),
                RaisedButton(
                    child: Text("Cancel"),
                    disabledTextColor: Colors.pinkAccent,
                    disabledColor: Colors.transparent),
              ],
            );
            */ /*Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Submitted"), behavior: SnackBarBehavior.floating));*/ /*
          });*/
    } else {
      //if all data not valid than start autovalidation
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          Fluttertoast.showToast(
              msg: value.toString(), toastLength: Toast.LENGTH_SHORT);
          correctScore++;
          break;
        case 1:
          Fluttertoast.showToast(
              msg: value.toString(), toastLength: Toast.LENGTH_SHORT);
          break;
        case 2:
          Fluttertoast.showToast(
              msg: value.toString(), toastLength: Toast.LENGTH_SHORT);
          break;
      }
    });
  }

  // show alertdialog
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      //out side click false.
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Form submit success"),
          content: Text("name: " + nameController.text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*
  * email validation
  * */
  String validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (email.isEmpty) {
      return 'Please enter email address';
    } else if (!regex.hasMatch(email))
      return 'Enter Valid Email';
    else
      return null;
  }

  /*
  * mobile validation.
  * */
  String validMobile(String mobileNumber) {
    if (mobileNumber.isEmpty)
      return 'Please enter Number';
    else if (mobileNumber.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

/*new Container(
        color: Colors.white,
        child: new Center(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Please choose your city: "),
                  new Container(
                    padding: new EdgeInsets.all(16.0),
                  ),
                  new DropdownButton(
                    value: _currentCity,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  )
                ])));*/

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }
}

List _cities = ["Vadodara", "Ahmedabad", "Surat", "Ankleshvar", "Vasad"];

List<DropdownMenuItem<String>> _dropDownMenuItems;
String _currentCity;

final _formKey = GlobalKey<FormState>();

//
FocusNode myFocusNode;

List<DropdownMenuItem<String>> getDropDownMenuItems() {
  List<DropdownMenuItem<String>> items = List();
  for (String city in _cities) {
    items.add(DropdownMenuItem(value: city, child: Text(city)));
  }
  return items;
}
