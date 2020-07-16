import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:yogaApp/Screens/Sleep/sleep_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:yogaApp/data/settings.dart';
import 'package:yogaApp/widgets/settings_card.dart';
import 'package:provider/provider.dart';
import 'package:ocarina/ocarina.dart';

class MeditatingScreen extends StatefulWidget {
  MeditatingScreen({this.startingAnimation = false, Key key}) : super(key: key);

  /// Determins if the starting animation should be played. It should only be played when the app is first launched from quit.
  final bool startingAnimation;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MeditatingScreen>
    with TickerProviderStateMixin {
  bool playSounds;
  bool isZenMode;
  bool _isPlaying = false;
  Duration _presetDuration;

  AnimationController _scaffold;
  AnimationController _logo;
  Animation<Offset> _animation;
  Animation<Offset> _logoAnimation;

  final sounds = [
    'Bell',
    'Bowl',
    'Flute',
    'Piano',
    'Stones',
    'Wind Chime',
  ];

  final soundMap = {
    1: 'assets/audios/meditation_bells.mp3',
    2: 'assets/audios/meditation_bowl.mp3',
    3: 'assets/audios/meditation_flute.mp3',
    4: 'assets/audios/meditation_piano.mp3',
    5: 'assets/audios/meditation_stones.mp3',
    6: 'assets/audios/meditation_wind_chimes.mp3',
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
    asset: 'assets/audios/meditation_bells.mp3',
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
