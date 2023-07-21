import 'package:cam/Widget/floating_button.dart';
import 'package:cam/Widget/showbar.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/cam_controller.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ScanController>(
          init: ScanController(),
          builder: (controller) {
            return controller.isCameraInitialized.value
                ? Stack(children: [
                    SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: CameraPreview(controller.cameraController),
                    ),
                    const FloatButto(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 1.h),
                        height: 7.h,
                        width: 50.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(153, 153, 136, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Set the desired border radius value
                            ),
                          ),
                          onPressed: () {
                            _displayBottonSheet(context);
                          },
                          child: Icon(Icons.model_training_outlined, size: 5.h),
                        ),
                      ),
                    ),
                  ])
                : const Column(
                    children: [
                      Text("Loading Preview...."),
                      // Text(controller.isCameraInitialized.value as String)
                    ],
                  );
          },
        ),
      ),
    );
  }

  Future _displayBottonSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return const ShowBar();
        });
  }
}
