import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class googleMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google Map",
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapDemoState();
}

class MapDemoState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  /* static const LatLng _center =
      const LatLng(37.42796133580664, -122.085749655962);*/

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  /*void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  */
  static final CameraPosition _destination = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToDestination,
        label: Text('Take me to lake'),
        icon: Icon(Icons.drive_eta),
      ),
    );
  }

  Future<void> _goToDestination() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_destination));
  }
}
