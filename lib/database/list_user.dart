import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/database/database_presenter.dart';
import 'package:fluttercomponent_demo/database/model/user.dart';
import 'add_user_dialog.dart';

class UsersList extends StatelessWidget {
  //lst of users
  List<User> users;
  DataBasePresenter dataBasePresenter;

  //constructor
  UsersList(
    List<User> this.users,
    DataBasePresenter this.dataBasePresenter, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //listview to bind the user list
    return ListView.builder(
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (BuildContext context, int index) {
          //cardview for item
          return Card(
            elevation: 5.0,
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      child: Text(getShortName(users[index])),
                      backgroundColor: Colors.black,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              users[index].firstName +
                                  " " +
                                  users[index].lastName,
                              // set some style to text
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.blue),
                            ),
                            Text(
                              "Address: " + users[index].address,
                              // set some style to text
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.mode_edit),
                          color: Colors.pinkAccent,
                          onPressed: () => edit(users[index], context),
                        ),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.pinkAccent,
                            onPressed: () => showDialog(
                                context: context,
                                barrierDismissible: false,
                                child: CupertinoAlertDialog(
                                  content: new Text(
                                    "Are you sure you want to delete?",
                                    style: new TextStyle(fontSize: 16.0),
                                  ),
                                  actions: <Widget>[
                                    //login button submit click
                                    FlatButton(
                                        onPressed: () {
                                          dataBasePresenter
                                              .delete(users[index]);
                                          //dissmiss confirmation dialog
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop("Discard");
                                          /*  Navigator.pop(context, true);
                                  _clearPreference(context);*/
                                        },
                                        child: Text("Yes")),
                                    FlatButton(
                                      onPressed: () {
                                        //ok button click
                                        //discard the alert dialog.
//                                Navigator.pop(context, 'Discard');
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop("Discard");
                                      },
                                      child: Text("No"),
                                    )
                                  ],
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  //reflect edit changes on the list
  displayRecord() {
    dataBasePresenter.updateScreen();
  }

  //edit user using User pojo // open pop-up with userdetails and update screen.
  edit(User user, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AddUserDialog().buildAboutDialog(context, this, true, user),
    );
    dataBasePresenter.updateScreen();
  }

  String getShortName(User user) {
    String shortName = "";
    if (!user.firstName.isEmpty) {
      shortName = user.firstName.substring(0, 1) + ".";
      print(user.firstName);
      print(user.lastName);
    }

    if (!user.lastName.isEmpty) {
      shortName = shortName + user.lastName.substring(0, 1);
    }
    return shortName;
  }
}
