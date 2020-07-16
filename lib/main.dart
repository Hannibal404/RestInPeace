import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yogaApp/Screens/Welcome/welcome_screen.dart';
import 'package:yogaApp/Screens/Yoga/poses.dart';
import 'package:yogaApp/Screens/Report/report.dart';

import 'package:yogaApp/pages_routes.dart';
import 'package:yogaApp/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'package:flutter/material.dart';
import 'Screens/Onboarding/onboard_model.dart';
import 'constants/theme.dart';
import 'constants/ui.dart';
import 'data/settings.dart';
import 'generated/l10n.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(
    MyApp(
      cameras: cameras,
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({
    this.cameras,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeditationModel(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, widget) {
          return ResponsiveWrapper.builder(
            widget,
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            background: Container(
              color: isDark(context) ? bgDark : fgDark,
            ),
          );
        },
        title: appTitle,

        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        // ignore: missing_return
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            // ignore: missing_required_param
            return PageRoutes.fade(() => Onboard());
          }
          if (settings.name == '/poses') {
            return PageRoutes.fade(() => Poses(
                  cameras: cameras,
                ));
          }
          if (settings.name == '/mainPage') {
            // ignore: missing_required_param
            return PageRoutes.fade(() => WelcomeScreen());
          }
        },
      ),
    );
  }
}
