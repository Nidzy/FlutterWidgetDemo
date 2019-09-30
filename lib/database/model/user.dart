//database pojo and the table for our database
class User {
  int id;
  String _firstName;
  String _lastName;
  String _dob;

  User(this._firstName, this._lastName, this._dob);

  //dynamic means we can change the value of that. ie dynamic a= 10 ; a= 'test'; // here a's type is dynamic so, we can not chnage its type .
  User.map(dynamic obj) {
    this._firstName = obj["firstname"];
    this._lastName = obj["lastname"];
    this._dob = obj["dob"];
  }

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get dob => _dob;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["firstname"] = _firstName;
    map["lastname"] = _lastName;
    map["dob"] = _dob;

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
