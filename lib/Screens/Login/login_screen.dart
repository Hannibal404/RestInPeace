import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/loginBody.dart';

class LoginScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const LoginScreen({this.cameras});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}
