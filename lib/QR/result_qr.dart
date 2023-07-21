import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

class ResultQR extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ResultQR({super.key, required this.code, required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              closeScreen();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            QrImageView(
              data: 'data',
              size: 150,
              version: QrVersions.auto,
            ),
            const Text(
              "Scanned Result ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "$code",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                letterSpacing: 1,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 4.2.h,
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Copy",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black87, letterSpacing: 1),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
