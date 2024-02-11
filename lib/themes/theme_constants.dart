import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(

  
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontFamily: "Prompt",
      
    )
  ),
  
  iconTheme: const IconThemeData(
    size: 24.0,
    fill: 0.0,
    weight: 400.0,
    grade: 0.0,
    opticalSize: 48.0, 
    color: Colors.white,
    opacity: 1.0,
  ),
  
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 81, 41, 30),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 237, 203, 177),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.black,
    background:Color.fromARGB(255, 146, 153, 130),
    onBackground: Colors.white,
    surface: Color.fromARGB(255, 0, 37, 0),
    onSurface: Colors.white,
  ), 
  
);