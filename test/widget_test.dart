// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:binbuddy_frontend/firebase_options.dart';
import 'package:binbuddy_frontend/net/vision.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('vision', (WidgetTester tester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      
      Vision.prepareFiles();
  });
  /*testWidgets('vision', (WidgetTester tester) async {
      await Vision.getImageProperties(Image.file(File("")), 0);
  });*/
}
