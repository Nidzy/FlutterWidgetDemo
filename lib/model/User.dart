class User {
  int id;
  String firstName;
  String number;
  String address;
  String email;
  String city;

  User(
      {this.id,
      this.firstName,
      this.number,
      this.address,
      this.email,
      this.city});

  factory User.fromJson(Map<String, dynamic> data) => new User(
        id: data["id"],
        firstName: data["first_name"],
        number: data["number"],
        address: data["address"],
        email: data["email"],
        city: data["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "number": number,
        "address": address,
        "email": email,
        "city": city,
      };


  //returns the map of details .
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'number': number,
      'address': address,
      'email': email,
      'city': city
    };
  }
}
