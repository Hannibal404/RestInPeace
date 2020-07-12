import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter_auth/Screens/Sleep/sleep_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/constants/preset_timers.dart';
import 'package:flutter_auth/constants/theme.dart';
import 'package:flutter_auth/constants/ui.dart';
import 'package:flutter_auth/data/settings.dart';
import 'package:flutter_auth/generated/l10n.dart';
import 'package:flutter_auth/pages_routes.dart';
import 'package:flutter_auth/Screens/Meditation/meditation_screen.dart';
import 'package:flutter_auth/widgets/settings_card.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocarina/ocarina.dart';
import 'package:audioplayer/audioplayer.dart';
import '../../components/audio_provider.dart';

class CityScreen extends StatefulWidget {
  CityScreen({this.startingAnimation = false, Key key}) : super(key: key);

  /// Determins if the starting animation should be played. It should only be played when the app is first launched from quit.
  final bool startingAnimation;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<CityScreen> with TickerProviderStateMixin {
  bool playSounds;
  bool isZenMode;
  bool _isPlaying = false;
  Duration _presetDuration;

  AnimationController _scaffold;
  AnimationController _logo;
  Animation<Offset> _animation;
  Animation<Offset> _logoAnimation;

  final sounds = [
    'City Airplane',
    'City Car',
    'City Fan',
    'City Rails',
    'City Subway',
    'City Traffic',
  ];

  final soundMap = {
    1: 'assets/audios/city_airplane.mp3',
    2: 'assets/audios/city_car.mp3',
    3: 'assets/audios/city_fan.mp3',
    4: 'assets/audios/city_rails.mp3',
    5: 'assets/audios/city_subway.mp3',
    6: 'assets/audios/city_traffic.mp3',
  };

  Map<int, bool> _isPlayingIndex = {
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
  };

  OcarinaPlayer _player = OcarinaPlayer(
    asset: 'assets/audios/city_airplane.mp3',
    loop: true,
    volume: 1,
  );

  play(int idx) async {
    if (_isPlayingIndex[idx + 1]) {
      _player.stop();
      _isPlaying = false;
      _isPlayingIndex[idx + 1] = false;
      _player.dispose();
      setState(() {});
    } else {
      if (_isPlaying) {
        _player.stop();
      }
      for (int i = 1; i <= 6; i++) {
        _isPlayingIndex[i] = false;
      }
      final player = OcarinaPlayer(
        asset: soundMap[idx + 1],
        loop: true,
        volume: 1,
      );
      setState(() {
        _player = player;
      });
      await _player.load();
      _isPlaying = true;
      _isPlayingIndex[idx + 1] = true;
      _player.play();
      print(_isPlaying);
    }
  }

  @override
  void initState() {
    super.initState();
    playSounds =
        Provider.of<MeditationModel>(context, listen: false).playSounds;
    isZenMode = Provider.of<MeditationModel>(context, listen: false).isZenMode;
    _presetDuration =
        Provider.of<MeditationModel>(context, listen: false).duration;

    _scaffold = AnimationController(
        vsync: this,
        value: widget.startingAnimation ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1800));
    _logo = AnimationController(
        vsync: this,
        value: widget.startingAnimation ? 0.0 : 1.0,
        duration: Duration(milliseconds: 1800));
    _animation =
        Tween<Offset>(begin: Offset(0, 0.25), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _scaffold, curve: Curves.easeOutQuart),
    );

    _logoAnimation =
        Tween<Offset>(begin: Offset(0, 0.65), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _logo,
        curve: Interval(
          0.25,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    if (widget.startingAnimation) {
      _scaffold.forward();
      _logo.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Explore Meditation",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Calming Sounds",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    height: cupertino.MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (BuildContext ctxt, int idx) {
                          print(idx);
                          return cupertino.GestureDetector(
                            onTap: () {
                              play(idx);
                            }, //Airplane
                            child: SettingsCard(
                              start: idx == 0 ? true : false,
                              end: idx == 5 ? true : false,
                              title: Text(
                                sounds[idx],
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              leading: Icon(Ionicons.ios_musical_note),
                              trailing: _isPlayingIndex[idx + 1]
                                  ? Icon(Ionicons.ios_pause)
                                  : Icon(Ionicons.ios_play),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// static String url =
//     'https://ucarecdn.com/9db9505e-c96b-482c-a4ef-7a5e16278810~36/nth/20/';
// static String url2 =
//     'https://ucarecdn.com/9db9505e-c96b-482c-a4ef-7a5e16278810~36/nth/21/';
// static String url3 =
//     'https://ucarecdn.com/9db9505e-c96b-482c-a4ef-7a5e16278810~36/nth/22/';
// static String url4 =
//     'https://ucarecdn.com/9db9505e-c96b-482c-a4ef-7a5e16278810~36/nth/23/';
// static String url5 =
//     'https://ucarecdn.com/9db9505e-c96b-482c-a4ef-7a5e16278810~36/nth/24/';
// static String url6 =
//     'https://ucarecdn.com/9db9505e-c96b-482c-a4ef-7a5e16278810~36/nth/25/';

// AudioPlayer audioPlayer = new AudioPlayer();

// AudioProvider audioProvider1 = new AudioProvider(url);
// AudioProvider audioProvider2 = new AudioProvider(url2);
// AudioProvider audioProvider3 = new AudioProvider(url3);
// AudioProvider audioProvider4 = new AudioProvider(url4);
// AudioProvider audioProvider5 = new AudioProvider(url5);
// AudioProvider audioProvider6 = new AudioProvider(url6);

// play1() async {
//   String localUrl1 = await audioProvider1.load();
//   audioPlayer.stop();
//   audioPlayer.play(localUrl1, isLocal: true);
// }

// play2() async {
//   String localUrl2 = await audioProvider2.load();
//   audioPlayer.stop();
//   audioPlayer.play(localUrl2, isLocal: true);
// }

// play3() async {
//   String localUrl3 = await audioProvider3.load();
//   audioPlayer.stop();
//   audioPlayer.play(localUrl3, isLocal: true);
// }

// play4() async {
//   String localUrl4 = await audioProvider4.load();
//   audioPlayer.stop();
//   audioPlayer.play(localUrl4, isLocal: true);
// }

// play5() async {
//   String localUrl5 = await audioProvider5.load();
//   audioPlayer.stop();
//   audioPlayer.play(localUrl5, isLocal: true);
// }

// play6() async {
//   String localUrl6 = await audioProvider6.load();
//   audioPlayer.stop();
//   audioPlayer.play(localUrl6, isLocal: true);
// }
