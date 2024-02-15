import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/screens/landing.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';
import 'screens/home.dart';
import 'themes/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart' show DefaultFirebaseOptions;
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*final users = await RequestSender.tryGetLeaderboard();

  for(var i = 0; i < users.length; i++) {
    print(users[i].name);
  }*/

  //RequestSender.trySignUp(User("ethan", "ethan@gmail.com", "bigmoneyethan", 0, 0));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LandingPage(),
      theme: defaultTheme,
    );
  }
}
