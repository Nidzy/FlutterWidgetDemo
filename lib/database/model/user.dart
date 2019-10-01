//database pojo and the table for our database
class User {
  int id;
  String _firstName;
  String _lastName;
  String _address;

  User(this._firstName, this._lastName, this._address);

  //dynamic means we can change the value of that. ie dynamic a= 10 ; a= 'test'; // here a's type is dynamic so, we can change its type .
  User.map(dynamic obj) {
    this._firstName = obj["firstname"];
    this._lastName = obj["lastname"];
    this._address = obj["address"];
  }

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get address => _address;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["firstname"] = _firstName;
    map["lastname"] = _lastName;
    map["address"] = _address;

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
