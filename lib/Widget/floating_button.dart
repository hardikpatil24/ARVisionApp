import 'package:cam/QR/barcode.dart';
import 'package:cam/Widget/scn_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FloatButto extends StatelessWidget {
  final bool serach;
  final bool textDete;
  final bool objectDete;
  const FloatButto({
    super.key,
    this.objectDete = false,
    this.textDete = false,
    this.serach = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.w, top: 3.h),
      child: Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: serach ? Colors.black : Colors.white,
              onPressed: () {
                Get.to(BarcodeScreen());
              },
              child: const Icon(
                Icons.search,
                color: const Color.fromRGBO(153, 153, 136, 1),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: serach ? Colors.black : Colors.white,
              onPressed: () {
                Get.to(() => TextReco());
              },
              child: const Icon(
                Icons.text_fields,
                color: const Color.fromRGBO(153, 153, 136, 1),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            FloatingActionButton(
              heroTag: "btn3",
              backgroundColor: serach ? Colors.black : Colors.white,
              onPressed: () {},
              child: const Icon(
                Icons.data_object,
                color: const Color.fromRGBO(153, 153, 136, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
