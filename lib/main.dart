import 'package:binbuddy_frontend/net/maps.dart';
import 'package:binbuddy_frontend/net/request_sender.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:binbuddy_frontend/screens/landing.dart';
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

  //Vision.prepareFiles();

  //await Maps.queryLocations("Electronic recycle", 43.258012, -79.919929);

  /*final users = await RequestSender.tryGetLeaderboard();

  for(var i = 0; i < users.length; i++) {
    print(users[i].name);
  }*/


  //RequestSender.trySignUp(User("ethan", "ethan@gmail.com", "bigmoneyethan", "", 0));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QueryMap(query: "Textile recycle"), //const LandingPage(),
      theme: defaultTheme,
    );
  }
}
