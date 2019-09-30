import 'package:flutter/material.dart';

void main() => runApp(MyTestApp());

//card with image, text and cross icon.
class MyTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
            appBar: AppBar(
              title: Text('MyTestApp'),
            ),
            body: Column(children: [
              Card(
                elevation: 4,
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/error.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 0, bottom: 0)),
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/food.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )),
                            Text('Food Paradise')
                          ],
                        ),
                      ],
                    )),
              ),
            ])));
  }
}
