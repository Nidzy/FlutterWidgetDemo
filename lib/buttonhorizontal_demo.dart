import 'package:flutter/material.dart';

class MyHorizontalButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget buttonSelection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomColumn(color, Icons.call, 'Call'),
          _buildBottomColumn(color, Icons.navigation, 'Navigation'),
          _buildBottomColumn(color, Icons.share, 'Share'),
        ],
      ),
    );

    return MaterialApp(
      /*title: 'Flutter horizontal Button Demo',*/
      home: Scaffold(
          appBar: AppBar(title: Text("Flutter Horizontal view")),
          body: buttonSelection),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: _MyHorizontalButton(title: 'Flutter Demo Home Page'),
    );
  }
}

/*class _MyHorizontalButton extends StatefulWidget {
  _MyHorizontalButton({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHorizontalButtonState();
}

class _MyHorizontalButtonState extends State<_MyHorizontalButton> {
  @override
  Widget build(BuildContext context) {}
}*/

Column _buildBottomColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: color),
        ),
      ),
    ],
  );
}
