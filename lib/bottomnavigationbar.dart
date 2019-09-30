import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/profile.dart';

import 'listdemo.dart';
import 'login.dart';
import 'home.dart';

void main() => runApp(NavigationScreen());

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NavigationPage(),
    );
  }
}

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  //bottomnavigationbar item click listeners
  final List<Widget> _bottomNavBarItem = [
    //pick image
    PickImage(),

    //static list with array
    ListDemo(),
    ProfileScreen()
    /*PlaceholderWidget(Colors.pinkAccent),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)*/
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _bottomNavBarItem[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            elevation: 5.0,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('List'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile'))
            ]));
  }

  //tab selection index
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
