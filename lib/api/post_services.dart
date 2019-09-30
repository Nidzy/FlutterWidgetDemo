import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fluttercomponent_demo/model/post_model.dart';
import 'dart:io';

//api to call
String url = 'https://jsonplaceholder.typicode.com/posts';

Future<List<Post>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  return allPostsFromJson(response.body);
}

Future<Post> getPost() async {
  final response = await http.get('$url/1');
  return postFromJson(response.body);
}

Future<http.Response> createPost(Post post) async {
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: postToJson(post));
  return response;
}

// this will give us the response from the api.
//here we write future keyword because we are going to get the responce
//getPost method will call the Api endpoint which is defined in the url. and we will receive a JSON string in response.body,
// which we have to send
/*Future<Post> getPostData() async {
  final response = await http.get('$url/1');
  return postFromJson(response.body);
}

Future<Post> createPost(Post post) async {
  final response = await http.post('$url',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: postToJson(post));
  return postFromJson(response.body);
}*/

//future builder has two main properties - future and builder. future needs a future and getpost() returns future.
//so the future will call the getPost() method.
/*FutureBuilder<Post>
(
future: getPostData
(
),builder: (
context, snapshot) {
return Text('${snapshot.data.title}');
}
)*/
