import 'dart:async';
import 'package:binbuddy_frontend/models/user.dart';

class RequestSender {

  String requestURI;

  RequestSender(this.requestURI);
  /*
  Future<User> tryLogin(String email, String password) async {
    try {
      final user = await SomeFunction that sends a request to the backend see if there is such user
      return user;
    } on UserNotFoundError catch (err) {
      return SomeFunction that tells the user that no such user was found.
    }

  }

  Future<User> trySignUp(User u) async {
    try {
      final id = await SomeFunction that sends a request to the backend to generate an id.
      User user = User(u.name, u.email, u.password, id, 0);
      return user;
    } on SomeError catch (err) {
      return SomeFunction that tells the user there was an error.
    }
  }
  
  */
}