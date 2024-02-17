import 'dart:async';
import 'package:binbuddy_frontend/models/stats.dart';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' show 
  FirebaseAuth;
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestSender {
  static const collection = "Users";
  static FirebaseFirestore db() => FirebaseFirestore.instance;

  static Future<User> getUser(String uid) async {
      final result = await db().collection(collection)
                          .where('id', isEqualTo: uid)
                          .get();
  
      if(result.docs.isEmpty) {
          throw "User not found";
      }

      //Data from the queried document
      var data = result.docs[0].data();

      return User.fromMap(data);
  }

  static Future<User> tryLogin(String email, String password) async {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  
      return await getUser(credential.user!.uid);
  }

  static Future<User> trySignUp(User user) async {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: user.email!,
              password: user.password!,
      );

      if(credential.user == null)
      {
        throw 'User creation failed';
      }
      user.removeSensitiveInfo();

      user.addID(credential.user!.uid);

      user.stats = Stats(0, 0, 0);

      await db().collection(collection).add(
        user.toSafeMap()
      );

      return user;
  }

  static Future<List<User>> tryGetLeaderboard() async {
      final result = await db().collection(collection)
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