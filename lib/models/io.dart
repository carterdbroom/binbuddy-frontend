import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

Future<Set<String>> readLines(String path) async {
    final lines = await rootBundle.loadString(path);

    return lines.split("\n").toSet();
}

Future<Set<String>> readFirebaseLines(String path) async {
    final ref = FirebaseStorage.instance.ref().child("recycle.txt");
    
    try {
      final data = await ref.writeToFile(File("C:\\test.txt"));
    } on FirebaseException catch (e) {
        print("Firebase error");
    }

    /*print(data);

    var text = utf8.decode(data!);

    print(text);*/

    return [""].toSet();
}