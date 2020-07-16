import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yogaApp/constants/theme.dart';
import 'package:yogaApp/data/quote.dart';
import 'package:yogaApp/generated/l10n.dart';
import 'package:yogaApp/pages_routes.dart';
import 'package:yogaApp/Screens/Meditation/main_screen.dart';
import 'package:yogaApp/utils/utils.dart';
import 'package:styled_widget/styled_widget.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 12.0),
                SizedBox(height: 36.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(68.0)),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(PageRoutes.fade(
                        () => MainScreen(
                          startingAnimation: false,
                        ),
                        milliseconds: 800,
                      ));
                    },
                    child: Text(
                      S.of(context).homeButton.toUpperCase(),
                      style: GoogleFonts.varelaRound(
                        color: fgDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ).padding(all: 18.0),
                  ),
                )
              ],
            ).padding(horizontal: 48.0),
          ),
        ),
      ),
    );
  }
}
