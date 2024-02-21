import 'package:binbuddy_frontend/net/maps.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:binbuddy_frontend/screens/landing.dart';
import 'package:binbuddy_frontend/screens/leaderboard.dart';
import 'package:binbuddy_frontend/screens/login.dart';
import 'package:binbuddy_frontend/screens/signup.dart';
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

class MyApp extends StatefulWidget {
    const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    User? user;

    void setUser(User u) {
        setState(() {
          user = u;
        });
    }

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => LandingPage(setUser: setUser, user: user),
          '/home': (context) => HomePage(user: user, setUser: setUser),
          '/wastewizard': (context) => WasteWizardPage(user: user, setUser: setUser),
          '/leaderboard': (context) => Leaderboard(user: user, setUser: setUser),
          '/login': (context) => LoginPage(setUser: setUser),
          '/signup': (context) => SignupPage(setUser: setUser),
        },
        theme: defaultTheme,
      );
    }
}
