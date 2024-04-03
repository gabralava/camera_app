import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_app/presentation/display_picture_screen.dart';
import 'package:camera_app/presentation/error_screen.dart';
import 'package:camera_app/presentation/location_finder.dart';
import 'package:camera_app/presentation/request_server.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String inputText = '';

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CameraApp')),
      body: Column(children: [
        TextField(
          onSubmitted: (text) {
            setState(() {
              inputText = text;
            });
          },
        ),
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        TextButton(
          onPressed: () async {
            await _initializeControllerFuture;
            _controller.setFlashMode(FlashMode.off);
            final image = await _controller.takePicture();
            Position position = await determinePosition();
            double latitude = position.latitude;
            double longitude = position.longitude;
            var response =
                await makeRequest(image.path, inputText, latitude, longitude);
            if (response == HttpStatus.ok) {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    imagePath: image.path,
                    inputText: inputText,
                    latitude: latitude,
                    longitude: longitude,
                  ),
                ),
              );
            } else {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ErrorScreen(
                    response: response,
                    imagePath: image.path,
                    inputText: inputText,
                    latitude: latitude,
                    longitude: longitude,
                  ),
                ),
              );
            }
          },
          child: const Text('Отправить запрос'),
        )
      ]),
    );
  }
}


