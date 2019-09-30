import 'dart:async';
import 'package:fluttercomponent_demo/database/databasehelper.dart';
import 'package:fluttercomponent_demo/database/model/user.dart';

abstract class DataBaseContract {
  void screenUpdate();
}

class DataBasePresenter {
  DataBaseContract _view;

  var db = DatabaseHelper();

  DataBasePresenter(this._view);

  //delete user from users
  delete(User user) {
//    var db = DatabaseHelper();
    db.deleteUsers(user);
    updateScreen();
  }

  //get all user
  Future<List<User>> getUser() {
    return db.getUser();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}
