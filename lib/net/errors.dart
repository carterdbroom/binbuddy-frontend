import 'package:firebase_auth/firebase_auth.dart';
class Errors {
  static String convertAuthError(FirebaseAuthException err) {
    if(err.code == "auth/user-not-found") {
      return "User not found, login information is incorrect";
    } else if(err.code == "auth/invalid-email") {
      return "Email is Invalid";
    } else if(err.code == "auth/invalid-password") {
      return "Password is Invalid";
    } else if(err.code == "auth/email-already-exists") {
      return "Email is already in use";
    } else {
      return "An unknown error has occured, login/signup failed. Information may be incorrect or server may be down. Please try again later.";
    }
  }
}