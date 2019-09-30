import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/database/add_user_dialog.dart';
import 'package:fluttercomponent_demo/database/database_presenter.dart';
import 'package:fluttercomponent_demo/database/list_user.dart';
import 'package:fluttercomponent_demo/database/model/user.dart';

class DataBaseMain extends StatefulWidget {
  DataBaseMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => DataBaseMainState();
}

class DataBaseMainState extends State<DataBaseMain>
    implements DataBaseContract {
  DataBasePresenter dataBasePresenter;

  @override
  void initState() {
    super.initState();
    dataBasePresenter = DataBasePresenter(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext buildContext) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            Text(
              'Users',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AddUserDialog().buildAboutDialog(context, this, false, null),
    );

//    setState(() {});
  }

  List<Widget> _actionItem() {
    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        onPressed: _openAddUserDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context),
        actions: _actionItem(),
      ),
      body: FutureBuilder<List<User>>(
        future: dataBasePresenter.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? UsersList(data, dataBasePresenter)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
