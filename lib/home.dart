import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercomponent_demo/map.dart';
import 'package:image_picker/image_picker.dart';
import 'formdemo.dart';

import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'database/database_main.dart';
import 'package:fluttercomponent_demo/capture_cameraimage.dart';
import 'package:fluttercomponent_demo/networkcall.dart';
import 'package:fluttercomponent_demo/googlemap.dart';
import 'package:fluttercomponent_demo/nearby.dart';

void main() => runApp(PickImage());

class PickImage extends StatefulWidget {
  final CameraDescription camera;

  const PickImage({Key key, this.camera}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickImageDemoState();
}

// allow user to select picture from gallery and camera.
class _PickImageDemoState extends State<PickImage> {
  Future<File> imageFile; // store image picked from gallery
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //to display the current output from camera , create camera controller.
    _controller = CameraController(
      //get specific camera from the list of available cameras.
      widget.camera,
      //Define a resolution to use.
      ResolutionPreset.medium,
    );

    //initialize the controller. this return a future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    //dispose of the controller when the widget is dispposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Image Pick Demo")),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                    elevation: 5.0,
                    onPressed: () {
                      onButtonPress(context);
                    },
                    child: Text('Open Form'),
                  ),*/
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                    elevation: 4,
                    shape: BeveledRectangleBorder(
                        side: BorderSide(style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Open Form"),
                    onPressed: () {
                      onFormOpen(context);
                    },
                  ),

                  //show picked image from gallery/ camera
                  showImage(),
                  OutlineButton(
                    padding: EdgeInsets.all(8.0),
                    textColor: Colors.pink,
                    color: Colors.pinkAccent,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 5.0,
                          style: BorderStyle.solid),
                    ),
                    onPressed: () {
                      pickImageFromGallery(ImageSource.gallery);
                    },
                    child: Text('Open Gallery'),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    elevation: 5.0,
                    onPressed: () {
                      captureImageFromCamera(ImageSource.camera);
                    },
                    child: Text('Open Camera'),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                    elevation: 5.0,
                    onPressed: () {
                      onDatabaseCall(context);
                    },
                    child: Text('Demo Sqflite'),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.pinkAccent,
                    elevation: 5.0,
                    onPressed: () {
                      onNetworkCall(context);
                    },
                    child: Text('Network Call'),
                  ),

                  RaisedButton(
                      padding: EdgeInsets.all(8.0),
                      textColor: Colors.white,
                      color: Colors.pinkAccent,
                      elevation: 5.0,
                      onPressed: () {
                        onMap(context);
                      },
                      child: Text('Google Map'))

                  //load image from network.. write the protocol expliciltly.
                  /*Image.network(
                  'http://www.google.de/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png'),*/
                ],
              ),
            )));
  }

  /*
  * show picked image into the imageview 
  * */
  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 150,
            height: 150,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  /*
  * pick image from gallery
  * */
  pickImageFromGallery(ImageSource gallery) {
    setState(() {
      imageFile =
          ImagePicker.pickImage(source: gallery, maxHeight: 400, maxWidth: 400);
    });
  }

  /*
  *  capture image from camera 
  * */

  captureImageFromCamera(ImageSource camera) {
    setState(() {
      imageFile =
          ImagePicker.pickImage(source: camera, maxHeight: 400, maxWidth: 400);
    });
  }

  /*
  *  capture image from camera.
  * */
  pickImageFromCamera() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Construct the path where the image should be saved using the
      // pattern package.
      final path = join(
        // Store the picture in the temp directory.
        // Find the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      // Attempt to take a picture and log where it's been saved.
      await _controller.takePicture(path);

      //if the picture was taken, display it on new screen.
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(imagePath: path)));
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  buildlist(void onDatabaseCall) {}
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

//navigator.push redirects the screen to form demo screen.
void onFormOpen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FormDemo()),
  );
}

void onNetworkCall(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NetworkCallDemo()),
  );
}

//redirect to users list/ add user screen
void onDatabaseCall(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => DataBaseMain()));
}

/*
* open camera
* */
void onCameraCapture(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => TakePictureScreen()));
}

/*
* open google map screen
* */
void onMap(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => googleMap()));
//  Navigator.push(context, MaterialPageRoute(builder: (context) => map()));
}
