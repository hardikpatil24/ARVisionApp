import 'package:cam/screens/camre_scree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(153, 102, 102, 1),
        // backgroundColor: Color.fromRGBO(204, 153, 102, 1),
        backgroundColor: const Color.fromRGBO(102, 153, 153, 1),
        // backgroundColor: Color.fromRGBO(204, 187, 153, 1),
        title: const Center(
          child: Text(
            "Main Page",
            style: TextStyle(),
          ),
        ),
      ),
      body: Container(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 12.h),
                height: 5.h,
                width: 50.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(153, 153, 136, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Set the desired border radius value
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const CameraScreen());
                    },
                    child: const Text("Start Camera")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
