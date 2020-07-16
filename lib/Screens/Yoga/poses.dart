import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yogaApp/screens/yoga/inference.dart';

class Poses extends StatelessWidget {
  final List<CameraDescription> cameras;
  final String title;
  final String model;
  final List<String> asanas;
  final Color color;

  const Poses({this.cameras, this.title, this.model, this.asanas, this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111015),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('Trikonasana', 'assets/Trikonasana.png', false,
                      false, context),
                  _buildCard(
                      'Bakasana', 'assets/Bakasana.png', false, false, context),
                  _buildCard(' Bhujangasana', 'assets/Bhujangasana.png', false,
                      false, context),
                  _buildCard('Dhanurasana', 'assets/Dhanurasana.png', false,
                      false, context),
                  _buildCard(
                      'Halasana', 'assets/Halasana.png', false, false, context),
                  _buildCard('Mayurasana', 'assets/Mayurasana.png', false,
                      false, context),
                  _buildCard('Padhastasana', 'assets/Padhastasana.png', false,
                      false, context),
                  _buildCard('Sarvangasana', 'assets/Sarvangasana.png', false,
                      false, context),
                  _buildCard('Sirsasana', 'assets/Sirsasana.png', false, false,
                      context),
                  _buildCard('Sukhasana', 'assets/Sukhasana.png', false, false,
                      context),
                  _buildCard(
                      'Tadasana', 'assets/Tadasana.png', false, false, context),
                  _buildCard('Ustrasana', 'assets/Ustrasana.png', false, false,
                      context),
                  _buildCard('Vrikshasana', 'assets/Vrikshasana.png', false,
                      false, context),
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(
      String name, String imgPath, bool added, bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () => _onSelect(context, name),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 8.0)
                  ],
                  color: Color(0xFF162447),
                ),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                      )),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 7.0),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ignore: sdk_version_ui_as_code
                            Text(name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Varela',
                                    fontSize: 24.0)),
                            // ignore: sdk_version_ui_as_code
                          ]))
                ]))));
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
