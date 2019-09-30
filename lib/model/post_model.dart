// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

//dart:convert => it converts json response to string.
import 'dart:convert';

//str is our json string . After decoding str, jsondata looks like this '
Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

List<Post> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}

String allPostsToJson(List<Post> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  //factory method create new post object.. that we can use in our application.
  //Post.fromJson requires an argument of the type Map<String, dynamic>.
  factory Post.fromJson(Map<String, dynamic> json) => new Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
