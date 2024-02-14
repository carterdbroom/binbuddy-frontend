import 'dart:async';
import 'dart:convert';
import 'package:binbuddy_frontend/models/user.dart';
import 'package:http/http.dart';

class RequestSender {

  String requestURI;

  RequestSender(this.requestURI);
  
  Future<Response> makePostRequest(String subPath, Object rawBody) async {
    return post(
      Uri.parse(requestURI + subPath),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: utf8.encode(jsonEncode(rawBody))
    );
  }

  Future<User> tryLogin(String email, String password) async {
      final response = await makePostRequest('/login', 
      {
        'email': email,
        'password': password
      });
        
      var body = jsonDecode(response.body) as Map<String, dynamic>;

      User user = User.fromMap(body['user']);
    
      return user;
  }

    Future<User> trySignUp(User user) async {
    final response = await makePostRequest('/signup',user.toMap());

    var body = jsonDecode(response.body) as Map<String, dynamic>;

    user.addID(body['id']);

    return user;
  }
}