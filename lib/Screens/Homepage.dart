import 'dart:async';
import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ocarina/ocarina.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OcarinaPlayer _player = OcarinaPlayer(
    asset: 'assets/audios/HouseOfBalloons.mp3',
    loop: true,
    volume: 0.8,
  );
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Container for header
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  ///Container for welcoming text
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning!",
                          style: GoogleFonts.playfairDisplay(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///vertical spacing
            SizedBox(
              height: 10,
            ),

            ///vertical spacing
            SizedBox(
              height: 10,
            ),

            ///Container for places list
            Expanded(
              child: Container(
                child: LayoutGrid(
                  columnGap: 10,
                  rowGap: 10,
                  templateColumnSizes: [
                    FlexibleTrackSize(1),
                    FlexibleTrackSize(1),

                    ///means 50% to both columns
                  ],
                  templateRowSizes: [
                    ///three rows
                    FlexibleTrackSize(1.0),
                    FlexibleTrackSize(0.8),
                    FlexibleTrackSize(1.0),

                    ///means first and third row will share same space but second will take 1/6 height compare to others
                  ],
                  children: [
                    ///Lets make container for each elements
                    getPlaceWidget("assets/5.svg").withGridPlacement(
                        rowStart: 0, columnStart: 0, rowSpan: 2),
                    getPlaceWidget2("assets/2.svg").withGridPlacement(
                        rowStart: 2, columnStart: 0, rowSpan: 1),
                    getPlaceWidget3("assets/4.svg").withGridPlacement(
                        rowStart: 0, columnStart: 1, rowSpan: 1),
                    getPlaceWidget4("assets/3.svg").withGridPlacement(
                        rowStart: 1, columnStart: 1, rowSpan: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPlaceWidget(imagePath) {
    return GestureDetector(
      onTap: () {
        ///For going on next screen
        Navigator.push(
            context,
            MaterialPageRoute(

                ///Send image path as we have setted it as tag of hero
                builder: (context) => HomeScreen()));
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.5,
                ),
              ],
              color: AppColors.greyBackground),
          child: Stack(
            children: [
              Hero(
                ///For hero animation on route transition
                tag: imagePath,
                child: ClipRRect(
                  child: SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              ///For rating and title
              Positioned(
                top: 2,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Meditation",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),

                    ///Rating
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget getPlaceWidget2(imagePath) {
    return GestureDetector(
      onTap: () async {
        final player = OcarinaPlayer(
          asset: 'assets/audios/HouseOfBalloons.mp3',
          loop: true,
        );

        setState(() {
          _player = player;
        });
        await _player.load();
        if (!_isPlaying) {
          _isPlaying = true;
          _player.play();
          print("Yes");
        } else {
          _isPlaying = false;
          _player.pause();

          print("No");
        }
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.5,
                ),
              ],
              color: AppColors.greyBackground),
          child: Stack(
            children: [
              Hero(
                ///For hero animation on route transition
                tag: imagePath,
                child: ClipRRect(
                  child: SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              ///For rating and title
              Positioned(
                top: 2,
                left: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sleep",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),

                    ///Rating
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget getPlaceWidget3(imagePath) {
    return GestureDetector(
      onTap: () {
        ///For going on next screen
        Navigator.push(
            context,
            MaterialPageRoute(

                ///Send image path as we have setted it as tag of hero
                builder: (context) => HomeScreen()));
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.5,
                ),
              ],
              color: AppColors.greyBackground),
          child: Stack(
            children: [
              Hero(
                ///For hero animation on route transition
                tag: imagePath,
                child: ClipRRect(
                  child: SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              ///For rating and title
              Positioned(
                top: 2,
                left: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Yoga",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),

                    ///Rating
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget getPlaceWidget4(imagePath) {
    return GestureDetector(
      onTap: () {
        ///For going on next screen
        Navigator.push(
            context,
            MaterialPageRoute(

                ///Send image path as we have setted it as tag of hero
                builder: (context) => HomeScreen()));
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.5,
                ),
              ],
              color: AppColors.greyBackground),
          child: Stack(
            children: [
              Hero(
                ///For hero animation on route transition
                tag: imagePath,
                child: ClipRRect(
                  child: SvgPicture.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              ///For rating and title
              Positioned(
                top: 2,
                left: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Relax",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),

                    ///Rating
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final OcarinaPlayer player;
  final VoidCallback onBack;

  PlayerWidget({this.player, this.onBack});

  @override
  Widget build(_) {
    return FutureBuilder(
        future: player.load(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
              return Text("Loading player");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("Error loading player");
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        child: Text("Play"),
                        onPressed: () async {
                          await player.play();
                        }),
                    RaisedButton(
                        child: Text("Stop"),
                        onPressed: () {
                          player.stop();
                        }),
                    RaisedButton(
                        child: Text("Pause"),
                        onPressed: () {
                          player.pause();
                        }),
                    RaisedButton(
                        child: Text("Resume"),
                        onPressed: () {
                          player.resume();
                        }),
                    RaisedButton(
                        child: Text("Seek to 5 secs"),
                        onPressed: () {
                          player.seek(Duration(seconds: 5));
                        }),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Volume"),
                      RaisedButton(
                          child: Text("0.2"),
                          onPressed: () {
                            player.updateVolume(0.2);
                          }),
                      RaisedButton(
                          child: Text("0.5"),
                          onPressed: () {
                            player.updateVolume(0.5);
                          }),
                      RaisedButton(
                          child: Text("1.0"),
                          onPressed: () {
                            player.updateVolume(1.0);
                          }),
                    ]),
                    RaisedButton(
                        child: Text("Dispose"),
                        onPressed: () async {
                          await player.dispose();
                        }),
                    RaisedButton(
                        child: Text("Go Back"),
                        onPressed: () async {
                          onBack?.call();
                        }),
                  ]);
          }
          return Container();
        });
  }
}
