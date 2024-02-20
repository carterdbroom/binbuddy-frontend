import 'package:binbuddy_frontend/net/maps.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:binbuddy_frontend/screens/landing.dart';
import 'package:binbuddy_frontend/screens/leaderboard.dart';
import 'package:binbuddy_frontend/screens/waste_wizard.dart';
import 'package:binbuddy_frontend/screens/widgets/query_map.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'screens/home.dart';
import 'themes/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart' show DefaultFirebaseOptions;
void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Vision.prepareFiles();

  //print(await Vision.testGetImageProperties());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(garbageValue: 0, compostValue: 0, recyclingValue: 0), // const LandingPage(),
      theme: defaultTheme,
    );
  }
}
