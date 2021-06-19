import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  static const routeName = 'TakePictureScreen';

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  XFile picture;
  Future<void> init() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                height: double.infinity,
                child: picture == null
                    ? 
                CameraPreview(_controller) 
                    :
                Image.file(File(picture.path)),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Container(
            height: 70,
            color: Colors.black26,
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                    splashRadius: 30,
                    splashColor: Colors.white,
                    onPressed: () async {
                      XFile picture = await _controller.takePicture();
                      print(picture.path);
                      picture.saveTo('Android/data/com.example.whatsapp_clone_mobile/files/Pictures');
                      setState(() {

                      });
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
