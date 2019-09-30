import 'package:flutter/material.dart';

void main() => runApp(ListDemo());

class ListDemo extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListDemo> {
  @override
  Widget build(BuildContext context) {
    // backing data
    final europeanCountries = [
      'Albania',
      'Andorra',
      'Armenia',
      'Austria',
      'Azerbaijan',
      'Belarus',
      'Belgium',
      'Bosnia and Herzegovina',
      'Bulgaria',
      'Croatia',
      'Cyprus',
      'Czech Republic',
      'Denmark',
      'Estonia',
      'Finland',
      'France',
      'Georgia',
      'Germany',
      'Greece',
      'Hungary',
      'Iceland',
      'Ireland',
      'Italy',
      'Kazakhstan',
      'Kosovo',
      'Latvia',
      'Liechtenstein',
      'Lithuania',
      'Luxembourg',
      'Macedonia',
      'Malta',
      'Moldova',
      'Monaco',
      'Montenegro',
      'Netherlands',
      'Norway',
      'Poland',
      'Portugal',
      'Romania',
      'Russia',
      'San Marino',
      'Serbia',
      'Slovakia',
      'Slovenia',
      'Spain',
      'Sweden',
      'Switzerland',
      'Turkey',
      'Ukraine',
      'United Kingdom',
      'Vatican City'
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Listview Demo'),
            ),
            body: ListView.builder(
                //only used when we want to add the divider
                /*separatorBuilder: (context, index) {
                  return Divider();
                },*/

                itemCount: europeanCountries.length,
                itemBuilder: (context, index) {
                  return /*ListTile(
                      title: Text('sdfkdhdf'),
                      subtitle: Text("jdfjfgj"));*/ /*children: <Widget>[*/
                      Column(children: [
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
//                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 0,
                                          bottom: 0)),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/food.jpg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 0,
                                          bottom: 0)),
                                  Text(europeanCountries[index]),
                                ],
                              ),
                              /* Container(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
                              'Alps. Situated 1,578 meters above sea level, it is one of the '
                              'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
                              'half-hour walk through pastures and pine forest, leads you to the '
                              'lake, which warms to 20 degrees Celsius in the summer. Activities '
                              'enjoyed here include rowing, and riding the summer toboggan run.',
                              softWrap:
                                  true, //will fill the column width before wrapping at a word boundary.
                            ),
                          )*/
                            ],
                          )),
                    ), /*
                    Expanded(
                      child: _ListPageState(europeanCountries),
                    )*/
                  ]);

                  /*])*/
                })));
  }
}
