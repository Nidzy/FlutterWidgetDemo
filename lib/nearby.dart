import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(mapnew());

class mapnew extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<mapnew> {
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(25.69893, 32.6421);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              title: Text('Map'),
              backgroundColor: Colors.blue[900],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _mainLocation,
                      zoom: 10.0,
                    ),
                    markers: this.myMarker(),
                    mapType: MapType.normal,
                    onMapCreated: (controller) {
                      setState(() {
                        myMapController = controller;
                      });
                    },
                  ),
                ),
              ],
            )));
  }

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: InfoWindow(
          title: 'Historical City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return _markers;
  }
}
