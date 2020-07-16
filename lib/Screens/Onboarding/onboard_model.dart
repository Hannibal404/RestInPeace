import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:yogaApp/Screens/Welcome/welcome_screen.dart';

class Onboard extends StatefulWidget {
  Onboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Onboard> {
  //Create a list of PageModel to be set on the onBoarding Screens.
  final pageList = [
    PageModel(
        color: const Color(0xFF162447),
        heroAssetPath: 'assets/3.png',
        title: Text('Welcome',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 40.0,
            )),
        body: Text('Feel less streesed & more mindful \n with Meditation',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            )),
        iconAssetPath: 'assets/3.png'),
    PageModel(
        color: const Color(0xFF3d348b),
        heroAssetPath: 'assets/4.png',
        title: Text('Practice Yoga',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 40.0,
            )),
        body: Text('Do your practice of physical exercise',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            )),
        iconAssetPath: 'assets/4.png'),
    PageModel(
      color: const Color(0xFF2b2d42),
      heroAssetPath: 'assets/5.png',
      title: Text('Sleep Sounds',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 40.0,
          )),
      body: Text('Fall asleep with natural sounds \n for a better dream',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          )),
      iconAssetPath: 'assets/5.png',
    ),
    // SVG Pages Example
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
        doneButtonText: "DONE",
        skipButtonText: "SKIP",
        pageList: pageList,
        onDoneButtonPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen())),
        onSkipButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/mainPage'),
      ),
    );
  }
}
