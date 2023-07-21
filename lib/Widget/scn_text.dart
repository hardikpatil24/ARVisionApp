import 'dart:io';

import 'package:cam/Widget/result_text.dart';
import 'package:cam/controller/cam_controller.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:sizer/sizer.dart';

class TextReco extends StatefulWidget {
  const TextReco({super.key});

  @override
  State<TextReco> createState() => _TextRecoState();
}

class _TextRecoState extends State<TextReco> {
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          Future<void> _scanImage() async {
            print("hio");
            // print(_cameraController.)

            final navigator = Navigator.of(context);

            try {
              final pictureFile =
                  await controller.cameraController.takePicture();

              final file = File(pictureFile.path);

              final inputImage = InputImage.fromFile(file);
              final recognizedText =
                  await textRecognizer.processImage(inputImage);

              await navigator.push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ResultScreen(text: recognizedText.text),
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('An error occurred when scanning text'),
                ),
              );
            }
          }

          return controller.isCameraInitialized.value
              ? Stack(
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: CameraPreview(controller.cameraController),
                    ),
                    FloatingActionButton(
                      onPressed: _scanImage,
                      child: Text("hello"),
                    )
                  ],
                )
              : Container(
                  child: Text("Loading"),
                );
        },
      ),
    ));
  }
}
