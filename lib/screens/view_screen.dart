import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key, required this.src});
  final String src;

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: widget.src,
      ar: true,
      
      cameraControls: true,
      backgroundColor: Colors.white,
    );
  }
}
