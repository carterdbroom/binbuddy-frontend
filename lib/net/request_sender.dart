import 'dart:async';
import 'dart:convert';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart' show 
  FirebaseAuth, FirebaseAuthException, UserCredential;
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestSender {
  /* Future<Response> makePostRequest(String subPath, Object rawBody) async {
    return post(
      Uri.parse(requestURI + subPath),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: utf8.encode(jsonEncode(rawBody))
    );
  } */

  static Future<UserCredential> tryLogin(String email, String password) async {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<UserCredential> trySignUp(User user) async {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: user.email!,
              password: user.password!,
      );

      if(credential.user == null)
      {
        throw 'User creation failed';
      }

      final db = FirebaseFirestore.instance;

      await db.collection('Leaderboard').add(
        {
          'id': credential.user!.uid,
          'score': 0,
          'name': user.name
        }
      );

      return credential;
  }

  static Future<List<User>> tryGetLeaderboard() async {
      final db = FirebaseFirestore.instance;

      final result = await db.collection('Leaderboard')
                .where('score', isGreaterThan: 0)
                .orderBy('score', descending: true)
                .get();

      List<User> output = [];

      for(var i = 0; i < result.size; i++) {
          output.add(User.fromMap(result.docs[i].data()));
      }

      return output;
  }
}