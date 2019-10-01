import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/database/databasehelper.dart';
import 'package:fluttercomponent_demo/database/model/user.dart';

/*
* dialog interface for add/edit screen.
* */

class AddUserDialog {
  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  final etFirstname = TextEditingController();
  final etLastname = TextEditingController();
  final etAddress = TextEditingController();
  User user;

  Widget buildAboutDialog(
      BuildContext context, _myHomePageState, bool isEdit, User user) {
    String _firstName, _lastName, _address;

    if (user != null) {
      this.user = user;
      etFirstname.text = user.firstName;
      etLastname.text = user.lastName;
      etAddress.text = user.address;
    }

    final GlobalKey<FormState> _addUserKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text(isEdit ? 'Update User' : 'Add User'),
      content: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        // it will work as a gravity.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              decoration: InputDecoration(labelText: "FirstName"),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: etFirstname,
              /* focusNode: _firstNameFocus,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _firstNameFocus, _lastNameFocus);
              },*/

              //textDirection: TextDirection.rtl,
              validator: (name) {
                if (name.isEmpty) {
                  return 'Please enter firstname';
                }
                return null;
              },
              onSaved: (String firstName) {
                _firstName = firstName;
              }),
          TextFormField(
              decoration: InputDecoration(labelText: "LastName "),
              keyboardType: TextInputType.text,
              //focusNode: _lastNameFocus,
              controller: etLastname,
              autofocus: false,
              textInputAction: TextInputAction.next,

              //for hiding the 1/10 lable from the form field.
              buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
              validator: (lastName) {
                if (lastName.isEmpty) {
                  return 'Please enter lastname ';
                }
                return null;
              },
              onSaved: (String lastName) {
                _lastName = lastName;
              }

              /*validator: (number) {
              if (number.isEmpty) {
                return 'Please enter Number';
              }
              return null;
            },*/
              ),
          TextFormField(
              decoration: InputDecoration(labelText: "Address"),
              keyboardType: TextInputType.text,
              autofocus: false,
              controller: etAddress,
              textInputAction: TextInputAction.done,
              validator: (address) {
                if (address.isEmpty) {
                  return 'Please enter Address';
                }
                return null;
              },
              onSaved: (String address) {
                _address = address;
              }),
          Container(
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: RaisedButton(
                color: Colors.pinkAccent,
                onPressed: () {
                  addRecord(isEdit);
                  _myHomePageState.displayRecord();
                  Navigator.of(context).pop();
                },
                child: Text(
                  isEdit ? "Update" : "Add",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )),

          /*GestureDetector(
            onTap: () {
              addRecord(isEdit);
              _myHomePageState.displayRecord();
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: getAppBorderButton(isEdit ? "Edit" : "Add",
                  EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
            ),
          ),*/
        ],
      )),
    );
  }

  //focus from one field to other field
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget getTextField(BuildContext context, String inputBoxName,
      TextEditingController inputBoxController, FocusNode focusNode) {
    var loginBtn = Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: inputBoxController,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  //add/ edit user details
  Future addRecord(bool isEdit) async {
    var db = DatabaseHelper();
    var user = User(etFirstname.text, etLastname.text, etAddress.text);
    if (isEdit) {
      user.setUserId(this.user.id);
      await db.update(user);
    } else {
      await db.saveUser(user);
    }
  }
}
