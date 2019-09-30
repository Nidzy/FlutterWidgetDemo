import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/api/post_services.dart';
import 'package:fluttercomponent_demo/model/post_model.dart';

void main() {
  runApp(new NetworkCallDemo());
//  loadProduct();
//  loadPhotos();
//  loadAddress();
//  loadStudent();
//  loadShape();
//  loadBakery();
//  loadPage();
}

class NetworkCallDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: NetworkCallScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NetworkCallScreen extends StatelessWidget {
  callAPI() {
    Post post = Post(body: 'body', title: 'Flutter');
    /*loadPage();
    loadShape();*/
    createPost(post).then((response) {
      if (response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error) {
      print('error : $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Post>(
            future: getPost(),
            builder: (context, snapshot) {
              callAPI();
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error");
                }

                return Text(
                    'Title from response JSON : ${snapshot.data.title}');
              } else
                return CircularProgressIndicator();
            }));
  }
}
