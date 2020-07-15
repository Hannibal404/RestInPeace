import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const WelcomeScreen({this.cameras});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
