import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/body.dart';
import 'package:flutter_auth/Screens/Yoga/inference.dart';

class WelcomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const WelcomeScreen({this.cameras});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }

  void _onSelect(BuildContext context, String customModelName) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InferencePage(
          cameras: cameras,
          title: customModelName,
          model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
          customModel: customModelName,
        ),
      ),
    );
  }
}
