import 'package:cam/screens/scn_qr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({super.key});

  @override
  State<BarcodeScreen> createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Scanner'),
        backgroundColor: const Color.fromRGBO(102, 153, 153, 1),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Barcode Scan"),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => QrCode()),
                child: const Text("QR Scan"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Barcode Scan stream"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
